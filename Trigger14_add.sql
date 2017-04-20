-- Description:
PRAGMA foreign_keys = ON;
drop trigger if exists trigger_bidNumber;
create trigger trigger_bidNumber after insert
ON Bid for each row
begin
  update Item
  set Currently = new.Amount
  where ItemId = new.ItemId;
end;
