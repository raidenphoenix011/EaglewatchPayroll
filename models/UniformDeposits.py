import db

    
class UniformDeposits(object):
  def __init__(self, FieldEmpID, Amount):
        
        self.FieldEmpID=FieldEmpID
        self.Amount=Amount
    
  def save(self):
    sql = "insert into UniformDeposits (FieldEmpID, Amount) values (%s, %s)"
    params = (self.FieldEmpID, self.Amount)
    db.ins(sql,params)
    
  def get(prop):
    sql = "select %s from UniformDeposits where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update UniformDeposits set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)

