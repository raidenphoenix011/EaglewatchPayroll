import db

class HolidayMOR(object):

  def __init__(self, Type, Description):
    self.Type = Type
    self.Description = Description
    
  def save(self):
    sql = "insert into HolidayMOR (type, description) values (%s, %s)"
    params = (self.type, self.description)
    db.ins(sql, params)

  def getDescription(HolidayMorType):
    sql = "select Description from HolidayMOR where Type = %s"
    return db.getOne(sql, HolidayMorType)   
  
  def get(prop):
    sql = "select %s from HolidayMOR where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update HolidayMOR set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)