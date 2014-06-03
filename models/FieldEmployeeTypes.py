import db

class FieldEmployeeTypes(object):
  
  def __init__(self, FEtype, description):
    self.type = FEtype
    self.description = description
    
  def save(self):
    sql = 'insert into FieldEmployeeTypes (type, description) values (%s, %s)'
    params = (self.type, self.description)
    db.ins(sql, params)

  def getDescription(FEtype):
    sql = 'select Description from FieldEmployeeTypes where type = %s'
    return db.getOne(sql, FEtype)    