-- Description: Check that no user can make a bid of the same amount to the same item
PRAGMA foreign_keys = ON;
drop trigger if exists trigger_bidAmount;
create trigger trigger_bidAmount before insert
ON Bid for each row
when exists (
  select * from Bid
  where Amount >= new.Amount and
        ItemId = new.ItemId
)
    -- select * from Item
    -- where Item.Amount = new.Amount and
    -- Item.ItemId = new.ItemId and
    -- Bid.BidderId = new.BidderId) IS NOT NULL)
Begin
  select RAISE(
  rollback, 'Amount can not be lower than current bid.');
end;
