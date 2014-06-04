import db

    
class Clients(object):
  def __init__(self, ID, Code, Name, BillingAddress, City, Landline):
    self.ID = ID
    self.Code=Code
    self.Name=Name
    self.BillingAddress=BillingAddress
    self.Landline=Landline
    self.City=City
    
  def save(self):
    sql = "insert into Clients (Code, Name, BillingAddress, Landline) values (%s, %s, %s, %s)"
    params = (self.Code, self.Name, self.BillingAddress, self.Landline)
    db.ins(sql,params)
    
  def getClient(Code):
    sql = "select Name, BillingAddress, Landline from Clients where Code = %s"
    return db.getOne(sql, Code)   
  
  def get(prop):
    sql = "select %s from Clients where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update Clients set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)


    
    
