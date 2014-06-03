import db

    
class PersonalPayables(object):
  def __init__(self, FieldEmpID, Type, Amount, PeriodCode, DateCreated):
        
        self.FieldEmpID=FieldEmpID
        self.Type=Type
        self.Amount=Amount
        self.PeriodCode=PeriodCode
        self.DateCreated=DateCreated
    
  def save(self):
    sql = "insert into PersonalPayables (FieldEmpID, Type, Amount, PeriodCode, DateCreated) values (%s, %s, %s, %s, %s)"
    params = (self.FieldEmpID, self.Type, self.Amount, self.PeriodCode, self.DateCreated)
    db.ins(sql,params)
    

  def get(prop):
    sql = "select %s from PersonalPayables where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update PersonalPayables set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
