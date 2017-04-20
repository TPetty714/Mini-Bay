-- Description: Guarantee that the number of bids is accurate
PRAGMA foreign_keys = ON;
drop trigger if exists bidNumber;
create trigger bidNumber after insert
ON Bid for each row
when exists (
  select * from Item
  where ItemID = new.ItemId and
  numberOfBids != (select count(*)
    from Bid
    where ItemId = new.ItemId)
)
begin
  update Item
  set numberOfBids = numberOfBids + 1
  where ItemId = new.ItemId;
end;
