-- Description: Checks that bid is within start and end times of item
PRAGMA foreign_keys = ON;
drop trigger if exists startTimeBeforeEndTime;
create trigger startTimeBeforeEndTime after insert
ON Bid for each row
when exists (
    select * from Item
    where ItemId = new.ItemId and
    new.bidTime < StartDate or
    new.bidTime > EndDate
)
begin
  select raise(rollback, 'Can only bid on open auctions');
end;
