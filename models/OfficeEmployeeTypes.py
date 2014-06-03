import db

    
class OfficeEmployeeTypes(object):
  def __init__(self, Type, Description):
        
    self.Type=Type
    self.Description=Description

    
  def save(self):
    sql = "insert into OfficeEmployeeTypes (Type, Description) values (%s, %s)"
    params = (self.Type, self.Description)
    db.ins(sql,params)
    
  def get(prop):
    sql = "select %s from OfficeEmployeeTypes where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update OfficeEmployeeTypes set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)














