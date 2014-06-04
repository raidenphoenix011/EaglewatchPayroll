import db

class Detachments(object):

  def __init__(self, ID, ClientID, RateID, Code, Name, Address, City, StartDate, EndDate, Status):
    self.ID=ID
    self.ClientID = ClientID
    self.RateID = RateID
    self.Code = Code
    self.Name = Name
    self.Address = Address
    self.City = City
    self.StartDate = StartDate
    self.EndDate = EndDate
    self.Status = Status
    self.ClientName = 'name'
    
  def setClientName(self, val):
    self.ClientName = db.getClientName(val)
    
  def save(self):
    sql = "insert into Detachments (ClientID, RateID, Code, Name, Address, City, StartDate, EndDate, Status) values (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.ClientID, self.RateID, self.Code, self.Name, self.Address, self.City, self.StartDate, self.EndDate, self.Status)
    return db.ins(sql, params)

  def get(prop):
    sql = "select %s from Detachments where ClientID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update Detachments set %s = %s where ClientID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)
