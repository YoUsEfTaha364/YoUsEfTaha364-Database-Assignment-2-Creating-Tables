# NOTES.md — BidNile Database Design & SQL Server DDL

Short answers (Section 03 of the assignment). The full script is
`database/BidNile.sql`; the data is `database/BidNile_Data.sql`;
the LeetCode solution is `dsa/ProductExceptSelf.cs`.

---

## 1. Your 4 schemas, their tables, and why

Exactly 4 schemas at CREATE time, one per business section of the
case — so a reader can find a table by asking "whose business is
this?":

| Schema | Tables | Why these together |
|---|---|---|
| `People` | `City`, `Member`, `Wallet` | Members: where they live, who they are, and their money. `City` lives here because a member's city is part of the member story, and every member lives in one city. |
| `Operations` | `Warehouse`, `Employee` | Warehouses and staff: the buildings and the people who work in them — including the circular manager relationship, which stays inside one schema. |
| `Catalog` | `Category`, `Item`, `ItemPhoto` | Catalogue: what is sold, how it is classified, and its photos. |
| `Sales` | `Auction`, `Bid`, `AuctionFollow` | Auctions and bidding: the sale itself, the bids on it, and who follows it. |

Task 3.12 then adds a **5th** schema, `Marketing`, and moves
`AuctionFollow` into it (`Marketing.AuctionFollow`) — that is a
later business change (marketing owns engagement data), not part
of the original 4. No table is in `dbo`, and every name is a
two-part name (`Schema.Table`).

---

## 2. For each relationship type: where it is in BidNile and how you mapped it

**1:1 — Member ↔ Wallet.**
One wallet per member, never shared. Mapped by making
`Wallet.MemberId` both the primary key **and** the foreign key to
`Member(MemberId)`. A wallet cannot exist without its member, and
a member cannot have a second wallet (the PK forbids it).
The same 1:1-subtype pattern is used for `Employee`: an employee
*is* a member, so `Employee.MemberId` is PK + FK to `Member`.

**1:N — many places, all mapped with a FK on the "many" side:**
- `City` 1:N `Member` — `Member.CityId → City.CityId`.
- `City` 1:N `Warehouse` — `Warehouse.CityId → City.CityId`.
- `Warehouse` 1:N `Employee` — `Employee.WarehouseId → Warehouse.WarehouseId`.
- `Category` 1:N `Item` — `Item.CategoryId → Category.CategoryId`.
- `Item` 1:N `Auction` — `Auction.ItemId → Item.ItemId` (an unsold
  item may have several auctions over time; item 1 in the data has
  auctions 1 and 2).
- `Auction` 1:N `Bid` and `Member` 1:N `Bid` — `Bid.AuctionId`,
  `Bid.MemberId` (a member can bid many times on the same auction).
- `Warehouse` 1:N `Item` — `Item.WarehouseId → Warehouse.WarehouseId`
  (NULL until the item arrives; item 7 has no warehouse yet).

**M:N — Member ↔ Auction (follows).**
A member follows many auctions, an auction has many followers,
nobody follows the same auction twice. Mapped with a junction
table, `AuctionFollow`, whose **composite PK is
`(MemberId, AuctionId)`** — that PK is exactly what forbids the
duplicate follow — plus `FollowedAt`. (Bidding is *not* an M:N
junction: a bid is a real event with its own amount, time and IP,
so it is its own table, `Bid`, with a `BIGINT IDENTITY` PK.)

**Recursive — two of them:**
- `Member.InvitedBy → Member.MemberId` — a member is invited by at
  most one member; a member can invite many. NULL = joined without
  an invitation. In the data, members 2, 3, 5, 7, 8 and 10 were invited.
- `Category.ParentCategoryId → Category.CategoryId` — Cars (110)
  under Vehicles (100), Mobiles (210) under Electronics (200);
  top-level categories have NULL.

**Circular — Warehouse ↔ Employee.**
`Employee.WarehouseId → Warehouse` (each employee works in exactly
one warehouse) **and** `Warehouse.ManagerId → Employee` (one
employee manages each warehouse; `ManagerId` is UNIQUE, so a
person manages at most one warehouse; `ManagerStartDate` exists
exactly when a manager exists — table CHECK). The circle is why
both FKs are added in 3.1 (see Q4). Loading the data needs the
same trick: insert the warehouse with `ManagerId = NULL`, insert
the employees, then `UPDATE` the warehouse to set its manager
(see Q5).

**Weak entity — `ItemPhoto`.**
A photo means nothing on its own: it is identified by its item
and its position (1st…20th) and disappears with its item. Mapped
with a **composite PK `(ItemId, PhotoOrder)`**, `PhotoOrder`
`TINYINT CHECK 1..20`, and `FK_ItemPhoto_Item … ON DELETE CASCADE`
— the only FK in the design with a cascade. Deleting an item
deletes its photos; every other FK is NO ACTION, so a referenced
city, member, warehouse, category, item or auction cannot be
deleted while it is still used.

Two more mappings worth naming: an item is linked to **two**
members — seller and inspector (`Item.SellerId`,
`Item.InspectorId`, both FKs to `Member`) — and they can never be
the same person, enforced by the table CHECK
`CK_Item_Seller_Inspector`. And `Item.WarehouseId` is NULL until
the item arrives.

---

## 3. Why GUID for members and BIGINT for bids? Why FLOAT for GPS but DECIMAL for money? Why DATETIMEOFFSET for auctions?

- **GUID (`UNIQUEIDENTIFIER`, `DEFAULT NEWID()`) for `MemberId`:**
  the mobile app generates the member ID on the phone itself,
  *before* the request reaches the server — so IDs must be
  globally unique without asking the server for the next number.
  An `IDENTITY` integer cannot do that (two phones would both
  generate "1"). A GUID can be generated anywhere, offline, and
  (practically) never collides; the server generates one with
  `NEWID()` only if the app didn't send one.

- **`BIGINT` for `BidId`:** hundreds of millions of bids a year —
  the counter passes 2.1 billion (the `INT` maximum,
  2,147,483,647) within a few years. `INT IDENTITY` would overflow
  and stop taking bids; `BIGINT IDENTITY` (up to ~9.2 quintillion)
  will not. Other counters (cities, items, auctions) stay `INT`
  because they will never get near 2.1 billion.

- **`FLOAT` for GPS, `DECIMAL` for money:** latitude/longitude are
  *approximate measurements* with many decimals (30.0444196 /
  31.2357116) — nobody is owed exactly 30.0444196 degrees, and
  `FLOAT` is the type for approximate, scientific measurements.
  Money is the opposite: it must be *exact*. `FLOAT` cannot
  represent 0.10 exactly, so adding money in `FLOAT` drifts by
  fractions of a piastre. `DECIMAL(12,2)` stores money exactly,
  to two decimal places, up to 9,999,999,999.99 — which is why
  `Balance`, `HeldAmount`, prices and amounts are all
  `DECIMAL(12,2)`. The same split is why the commission is
  `DECIMAL(5,2)` (an exact percentage with two decimals).

- **`DATETIMEOFFSET` for auctions:** members live in Cairo
  (+02:00), Riyadh (+03:00) and Dubai (+04:00). An auction that
  ends at "18:30" means something different in each city, and a
  plain `DATETIME2` would silently lose that. `DATETIMEOFFSET`
  keeps the offset with the value (`2026-12-05 18:30 +04:00`), so
  start/end are comparable across time zones and the end is
  always after the start (table CHECK `EndAt > StartAt`).
  Moments that are just "when did this happen on our server"
  (registration, a bid being placed, a listing) don't need an
  offset and use `DATETIME2(3)` — exact to the millisecond.

---

## 4. Why can't the circular relationship be created inside CREATE TABLE?

Because of the circle itself: `Employee` references `Warehouse`
(works in) **and** `Warehouse` references `Employee` (managed by).
Inside `CREATE TABLE`, a foreign key can only reference a table
that already exists. Whichever table you create first, the other
one does not exist yet — `CREATE TABLE Warehouse` with a FK to
`Employee` fails because there is no `Employee`, and
`CREATE TABLE Employee` with a FK to `Warehouse` fails because
there is no `Warehouse`. There is no order that works.

So Task 2 creates both tables with the FK **columns** only
(`Warehouse.ManagerId`, `Employee.WarehouseId`) and no FK
constraints, and Task 3.1 adds both FK constraints with
`ALTER TABLE … ADD CONSTRAINT` once both tables exist. The same
reason is why the data load inserts the warehouse first with a
NULL manager and sets the manager afterwards (Q5). The recursive
FKs (`Member.InvitedBy`, `Category.ParentCategoryId`) do *not*
have this problem — a table can reference itself, because it
exists by the time its own FK is added — but they are still added
in 3.1, with all the others, to keep one rule: no FK inside
`CREATE TABLE`.

---

## 5. The order you filled the tables in, and why

A row can only be inserted after every row it points to already
exists — otherwise the FK rejects it. The order in
`database/BidNile_Data.sql` is:

1. `People.City` — nothing points to it yet; everything else
   needs it. (7 rows)
2. `People.Member` — needs its city; **inviters before the
   members they invited** (member 1 before members 2 and 3,
   member 2 before member 5, member 3 before member 8).
   (10 rows)
3. `People.Wallet` — 1:1 with `Member`, so after the members.
   (10 rows)
4. `Operations.Warehouse` — needs its city. In the wizard you
   enter it with the manager blank at first (the manager must be
   an employee, and no employee exists yet — the circular
   relationship, Q4), then you set the manager once the employees
   exist. The **final stored values have no NULLs**: every
   warehouse has a manager who works in it — W1 Layla (member 4,
   from 2025-02-01), W2 Nour (member 6, 2025-02-10), W3 Huda
   (member 9, 2025-03-01), W4 Mona (member 7, 2025-03-05),
   W5 Ziad (member 10, 2025-03-10). (5 rows)
5. `Operations.Employee` — needs its member and its warehouse.
   (6 rows)
6. (No separate step — the managers above are the final values
   in `BidNile_Data.sql`; the file now contains INSERTs only,
   no UPDATEs.)
7. `Catalog.Category` — **parents before children** (100, 200,
   300 before 110, 210). (5 rows)
8. `Catalog.Item` — needs seller, category, warehouse and
   inspector. (8 rows; item 7 has `WarehouseId = NULL` — not
   arrived yet)
9. `Catalog.ItemPhoto` — needs its item. (14 rows)
10. `Sales.Auction` — needs its item. (8 rows)
11. `Sales.Bid` — needs its auction and its bidder. (40 rows)
12. `Marketing.AuctionFollow` — needs its member and its
    auction. (12 rows; it lives in `Marketing` after 3.12)

Counts: 7 cities, 10 members, 10 wallets, 5 warehouses,
6 employees, 5 categories, 8 items, 14 photos, 8 auctions,
40 bids, 12 follows — every table has at least 5 rows.
Coverage in the data: every auction status (Draft, Live, Ended,
Cancelled, PendingReview); auctions in +02:00, +03:00 and +04:00;
JSON specs with different keys for cars
(`{"brand":"Toyota","model":"Corolla","year":2019,"mileageKm":85000}`)
and phones (`{"storage":"256GB","colour":"Sierra Blue"}`);
member 1 (Ahmed) both sells item 1/8 and bids on auction 3;
invited members; warehouses with employees and a manager.

---

## 6. The errors in 3.6 and 3.11, and how you fixed them

**3.6 — changing `MaxItems` to `SMALLINT`.**
`ALTER COLUMN` failed because a CHECK constraint depends on the
column:

> Msg 5074 — The object `CK_Warehouse_Capacity` is dependent on
> column `MaxItems`. ALTER TABLE ALTER COLUMN MaxItems failed
> because one or more objects access this column.

SQL Server will not change a column's type while a constraint
references it. Fix: drop the CHECK first, alter the column, then
re-add the same "> 0" rule under its new name
(`CK_Warehouse_MaxItems`). The smallest type that fits 30,000 is
`SMALLINT` (−32,768…32,767): `TINYINT` tops out at 255 and `INT`
is far larger than needed. (On live data you would also have to
check no warehouse already holds more than 32,767 items; in the
Task 4 data every warehouse is ≤ 15,000.)

**3.11 — dropping the `IsVerified` column.**
`DROP COLUMN` failed because something is attached to the column
— its DEFAULT constraint:

> Msg 5074 — The object `DF_Member_IsVerified` is dependent on
> column `IsVerified`. ALTER TABLE DROP COLUMN IsVerified failed
> because one or more objects access this column.

Fix: add `VerifiedAt DATETIME2(3) NULL` first, then
`DROP CONSTRAINT DF_Member_IsVerified`, then
`DROP COLUMN IsVerified`. The rule to remember: **a column cannot
be dropped (or re-typed) while a named constraint depends on it —
drop the constraint first, then the column.**

The three Task 4 error screenshots (`docs/screenshots/`) are the
same idea, reproduced on the loaded data — run each statement in
SSMS to see the identical message:

- Duplicate bid amount in one auction —
  `INSERT INTO Sales.Bid … VALUES (1, '…1102', 151000.00, …)` →
  Msg 2627, `UQ_Bid_Auction_Amount`, duplicate key (1, 151000.00).
- Held amount > balance —
  `UPDATE People.Wallet SET HeldAmount = 30000.00 WHERE MemberId = '…1101'`
  (balance 25000.00) → Msg 547, `CK_Wallet_HeldAmount_Balance`.
- Item inspected by its own seller —
  `UPDATE Catalog.Item SET InspectorId = SellerId WHERE ItemId = 1` →
  Msg 547, `CK_Item_Seller_Inspector`.

---

## 7. Task 5 — LeetCode 238, hand trace for [1, 2, 3, 4]

`prefix[i]` = product of everything **before** `i`;
`suffix[i]` = product of everything **after** `i`;
`answer[i] = prefix[i] * suffix[i]`. No division anywhere.

| i | nums[i] | prefix[i] (before i) | suffix[i] (after i) | answer[i] = prefix × suffix |
|---|---|---|---|---|
| 0 | 1 | 1 (nothing before) | 2 × 3 × 4 = **24** | 1 × 24 = **24** |
| 1 | 2 | 1 = **1** | 3 × 4 = **12** | 1 × 12 = **12** |
| 2 | 3 | 1 × 2 = **2** | 4 = **4** | 2 × 4 = **8** |
| 3 | 4 | 1 × 2 × 3 = **6** | 1 (nothing after) | 6 × 1 = **6** |

Result: **[24, 12, 8, 6]**.

- **5.1** (`ProductExceptSelfPrefixSuffix`): three linear passes,
  `prefix[]` and `suffix[]` arrays. Time O(n), space O(n) extra.
- **5.2** (`ProductExceptSelfO1Space`): the output array itself
  holds the prefix products, and one scalar `suffix` folds the
  right-hand products in on the way back. Time O(n), space O(1)
  extra (the output array doesn't count). Both versions are in
  `dsa/ProductExceptSelf.cs`; screenshot:
  `docs/screenshots/leetcode-accepted.png`.
