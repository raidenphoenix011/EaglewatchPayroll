import db

class RateTypes(object):

  def __init__(self, Type, Description):
    self.Type = Type
    self.Description = Description
    
  def save(self):
    sql = "insert into RateTypes (type, description) values (%s, %s)"
    params = (self.type, self.description)
    db.ins(sql, params)

  def getDescription(RateTypes):
    sql = "select Description from RateTypes where Type = %s"
    return db.getOne(sql, RateTypes)  

  
  def get(prop):
    sql = "select %s from RateTypes where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update RateTypes set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)