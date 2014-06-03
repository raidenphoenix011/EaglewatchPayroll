import db

class Allowances(object):

  def __init__(self, ID, DetachID, GuardID, Amount, LastUpdateDate, Status):
    self.ID = ID
    self.DetachID = DetachID
    self.GuardID = GuardID
    self.Amount = Amount
    self.LastUpdateDate = LastUpdateDate
    self.Status = Status

  #def save(self):
    #sql = "insert into DetachmentContactPersons (ID, DetachID, GuardID, Amount, LastUpdateDate, Status) values (%s, %s, %s, %s, %s, %s)"
    #params = (self.ID, self.DetachID, self.GuardID, self.Amount, self.LastUpdateDate, self.Status)
    #return db.ins(sql, params)

  def save(self):
    sql = "insert into Allowances (ID, DetachID, GuardID, Amount, LastUpdateDate, Status) values (%s, %s, %s, %s, %s, %s)"
    params = (self.ID, self.DetachID, self.GuardID, self.Amount, self.LastUpdateDate, self.Status)
    try: 
      cur.execute(sql, params)
      res = cur.fetchall()
      return res[0]
    except MySQLdb.Error, e:
      print str(e.args[0]) + ': ' + str(e.args[1])
      #print 'Error retrieving data from the database'
      return None

  def get(prop):
    sql = "select %s from Allowances where ID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update Allowances set %s = %s where ID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)
