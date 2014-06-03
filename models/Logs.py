import db

class Logs(object):
  def __init__(self, EmpID, Type, Description, Timestamp):
        
    self.EmpID=EmpID
    self.Type=Type
    self.Description=Description
    self.Timestamp=Timestamp

  def save(self):
    sql = "insert into Logs (EmpID, Type, Description, Timestamp) values (%s, %s, %s, %s)"
    params = (self.EmpID, self.Type, self.Description, self.Timestamp)
    db.ins(sql,params)
     

  def get(prop):
    sql = "select %s from Logs where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update Logs set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)






