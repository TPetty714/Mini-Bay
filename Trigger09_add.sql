PRAGMA foreign_keys = ON;
DROP TRIGGER if EXISTS sameUser;
CREATE TRIGGER sameUser after INSERT
ON Bid for each row
WHEN exists(
    new.BidderId not in (SELECT SellerId FROM Item
    WHERE ItemId = NEW.ItemId)
)
begin
select RAISE(ROLLBACK, 'Can not bid on your own item')
END;
