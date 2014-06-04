import db

class IncentiveMOR(object):

  def __init__(self, Type, Description):
    self.Type = Type
    self.Description = Description
    
  def save(self):
    sql = "insert into IncentiveMOR (type, description) values (%s, %s)"
    params = (self.type, self.description)
    db.ins(sql, params)

  def getDescription(IncentiveMorType):
    sql = "select Description from IncentiveMOR where Type = %s"
    return db.getOne(sql, IncentiveMorType)  

  
  def get(prop):
    sql = "select %s from IncentiveMOR where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update IncentiveMOR set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)