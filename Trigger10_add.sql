-- Description: Check that no auction may have two bids at the exact same time.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger_diffBidTime;
create trigger trigger_diffBidTime before insert
ON Bid for each row
when exists (
    select * from Bid
    where bidTime = new.bidTime and
    new.bidTime in (
      select bidTime
      from Bid
    )
)
begin
  select raise(rollback,'Bids must have unique times');
end;
