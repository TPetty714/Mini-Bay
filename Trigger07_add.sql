-- Description: Checks that start time is before end time
PRAGMA foreign_keys = ON;
drop trigger if exists startTimeBeforeEndTime;
create trigger startTimeBeforeEndTime after insert
ON Item for each row
when exists (
    select * from Item
    where ItemId = new.ItemId and
    new.StartDate >= new.EndDate
)
begin
  select raise(rollback, 'Start date must be after End date');
end;
