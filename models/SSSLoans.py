import db

    
class SSSLoans(object):
  def __init__(self, FieldEmpID, Amount, MontlyPay, Balance, Status):
        
        self.FieldEmpID=FieldEmpID
        self.Amount=Amount
        self.MonthlyPay=MonthlyPay
        self.Balance=Balance
        self.Status=Status
    
  def save(self):
    sql = "insert into SSSLoans (FieldEmpID, Amount, MontlyPay, Balance, Status) values (%s, %s, %s, %s, %s)"
    params = (self.FieldEmpID, self.Amount, self.MontlyPay, self.Balance, self.Status)
    db.ins(sql,params)
    
  def get(prop):
    sql = "select %s from SSSLoans where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update SSSLoans set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)


