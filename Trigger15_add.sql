--description: Checks to make sure all added bids start at the current time
PRAGMA foreign_keys = ON;
drop trigger if exists newBidStart;
create trigger newBidStart after insert
ON Bid for each row
when exists (
    select * from Bid
    where
    ItemId = new.ItemId and
    BidderId = new.BidderId and
    bidTime = new.BidTime and
    bidTime not in (
      select presentTime
      from CurrentTime limit 1
    ) and
    Amount = new.Amount
)
begin
  select raise(rollback, 'New bids must be at current time');
end;
