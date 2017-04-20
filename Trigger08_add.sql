--description: item will always match the amount of the most recent bid
PRAGMA foreign_keys = ON;
DROP TRIGGER if EXISTS recentBid;
CREATE TRIGGER recentBid AFTER INSERT ON Bid
BEGIN
	UPDATE Item
	SET Currently = NEW.Amount
	where(Item.ItemId = NEW.ItemId);
END;
