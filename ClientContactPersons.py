import db
class ClientContactPersons(object):
  def __init__(self, ClientID, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, BirthDate)
    self.ClientID=ClientID 
    self.Suffix=Suffix
    self.LastName=LastName 
    self.FirstName=FirstName 
    self.MiddleName=MiddleName
    self.Landline=Landline
    self.MobileNo=MobileNo
    self.BirthDate=BirthDate
    

  def save(self):
    sql = "insert into ClientContactPersons (ClientID, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, Birthdate) values (%s, %s, %s, %s, %s, %s, %s, %s) 
    params = (self.ClientID, self.Suffix, self.LastName, self.FirstName, self.MiddleName, self.Landline, self.MobileNo, self.BirthDate)
    db.ins(sql,params)
    
  def getClientContactDetails(ClientID):
    sql = "select Suffix, FirstName, MiddleName, LastName, BirthDate, Landline, MobileNo from ClientContactPersons where ClientID = %s"
    return db.getOne(sql, ClientID)    


  def get(prop):
    sql = "select %s from ClientContactPersons where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update ClientContactPersons set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
