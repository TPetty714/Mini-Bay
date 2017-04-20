drop table if exists 'Item';
drop table if exists 'Users';
drop table if exists 'Bid';
drop table if exists 'Category';
drop table if exists 'CurrentTime';

create table CurrentTime (
	presentTime	integer
);

insert into CurrentTime (presentTime) values(
	'2001-12-20 00:00:01'
);

create table 'Item'(
	'ItemId'	integer not null,
	'Name'		text not null,
	'Currently' integer not null,
	'BuyPrice'	integer,
	'FirstBid'	integer not null,
	'StartDate' integer not null,
	'EndDate' 	integer not null,-- check (EndDate > StartDate),
	'SellerId'	text not null,
	'Description' text not null,
	'numberOfBids' integer,
	primary key('ItemId'),
	foreign key('SellerId') references 'Users'('UserId')
);
create table 'Users'(
	'UserId'	text not null,
	'Rating'	integer not null,
	'Location'	text,
	'Country'	text,
	primary key('UserId')
);

create table 'Bid'(
	'ItemId' 	integer not null,
	'BidderId'  text not null,
	'bidTime'		integer not null,
	'Amount'	integer not null,
	primary key('ItemId', 'BidderId', 'bidTime'),
	foreign key('ItemId') references 'Item'('ItemId'),
	foreign key('BidderId') references 'Users'('UserId')
);

create table 'Category'(
	'ItemId'	integer not null,
	'Category'	text not null,
	primary key('ItemId', 'Category'),
	foreign key('ItemId') references 'Item'('ItemId')
);
