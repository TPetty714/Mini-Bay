import sys; sys.path.insert(0, 'lib') 
import web

db = web.database(dbn='sqlite', db='data.db')

######################BEGIN HELPER METHODS######################

# Enforce foreign key constraints
# WARNING: DO NOT REMOVE THIS!
def enforceForeignKey(): db.query('PRAGMA foreign_keys = ON')

# initiates a transaction on the database
def transaction(): return db.transaction()
# Sample usage (in auctionbase.py):
#
# t = sqlitedb.transaction()
# try:
#   sqlitedb.query('[FIRST QUERY STATEMENT]')
#   sqlitedb.query('[SECOND QUERY STATEMENT]')
# except Exception as e:
#   t.rollback()
#   print str(e)
# else:
#   t.commit()
#
# check out http://webpy.org/cookbook/transactions for examples



# returns the current time from your database
def getTime():
  query_string = 'select presentTime from CurrentTime'
  results = query(query_string)
  return results[0].presentTime  # alternatively: return results[0]['time']



def setTime(new_time):
  t = db.transaction()
  try:
    db.update('CurrentTime', where="presentTime", presentTime = new_time)
  except Exception as e:
    t.rollback()
    print str(e)
  else:
    t.commit()



# returns a single item specified by the Item's ID in the database
def getItemById(item_id):
  q = 'select * from Item where ItemId = $ItemId'
  result = query(q, { 'ItemId': item_id })

  try:
    return result[0]
  except IndexError:
    return None



def getBidsByItemId(itemID):
  q = 'select * from Bid where itemID = $itemID'
  return query(q, {'itemID': itemID})



# returns a single item specified by the Item's ID in the database
def getUserById(user_id):
  q = 'select * from Users where UserId = $UserId'
  result = query(q, { 'UserId': user_id })

  try:
    return result[0]
  except IndexError:
    return None

def getItem(itemId):
	q = 'select * from Item'
	q+= 'where ItemId == itemId'
	return quary(q)

#def getItems(itemid = '', name = '', category = '', minPrice = '', maxPrice = '', startTime = '', endTime = '', status = 'all'):
  # Create basic query that selects all items
#  q = 'select * from Item'
    ############# 'where ends > (select time from currenttime)'

#  if (itemid != '') or (name != '') or (category != '')  or (minPrice = '') or (maxPrice != '') or (startTime = '') or (endTime = '') or (status != 'all'):
#    q += ' where '

  # If params for the search are indicated, add them to
  # narrow down the query
#  if vars != {}:
#    q += web.db.sqlwhere(vars, grouping=' AND ')

  # If min- and/or maxPrice are defined, append those restrictions to query
#  if (minPrice != '') or (maxPrice != ''):
#    if vars != {}:                          q += ' AND '
#    if (minPrice != ''):                    q += ' Currently >= ' + minPrice
#    if (minPrice != '' and maxPrice != ''): q += ' AND '
#    if (maxPrice != ''):                    q += ' Currently <= ' + maxPrice

#  if (status != 'all'):
#    if (vars != {}) or (minPrice != '') or (maxPrice != ''):
#      q += ' AND '
#    if status == 'open':
#      q += 'ends >= (select time from currenttime) and started <= (select time from currenttime)'
#    if status == 'close':
#      q += 'ends < (select time from currenttime)'
#    if status == 'notStarted':
#      q += 'started > (select time from currenttime)'

  # Return result of the query
#  return query(q)



def updateItemEndTime(itemID, new_end_time):
  db.update('Item',  where='ItemId = ' + itemID,  EndDate = new_end_time)

def addBid(itemId, price, userId, current_time):
    t = sqlitedb.transaction()
    try:
        db.insert('Bid', ItemId = itemId, BidderId = userId, bidTime = current_time, Amount = price)
    except Exception as e:
       t.rollback()
       print str(e)
    else:
       t.commit()
       
def getWinnerId(itemID):
  q  = 'select BidderID from Bid '
  q += 'where ItemId = $ItemId '
  q += 'and Amount = ('
  q +=   'select max(Amount) from Bid '
  q +=   'where ItemId = $ItemId'
  q += ')'

  result = query(q, { 'ItemId': itemID })

  try:
    return result[0].bidderID
  except IndexError:
    return None

# wrapper method around web.py's db.query method
# check out http://webpy.org/cookbook/query for more info
def query(query_string, vars = {}):
  return list(db.query(query_string, vars))

def addUser(userId, rating, location, country):
    t = sqlitedb.transaction()
    try:
        db.insert('Users', UserID = userID, Rating = rating, Location = location, Country = country)
        #db.update Users set Location=null where Location='NULL'
        #db.update Users set Country=null where Location='NULL'
    except Exception as e:
       t.rollback()
       print str(e)
    else:
       t.commit()


#####################END HELPER METHODS#####################
