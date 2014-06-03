import db

    
class Receivables(object):
  def __init__(self, FieldEmpID, CholFund, EmpFileFund, HolidayPay, ThirteenMonthPay, IncentivesPay, UniAllowance, UniDeposit):
        
        self.FieldEmpID=FieldEmpID
        self.CholFund=CholFund
        self.EmpFileFund=EmpFileFund
        self.HolidayPay=HolidayPay
        self.ThirteenMonthPay=ThirteenMonthPay
        self.IncentivesPay=IncentivesPay
        self.UniAllowance=UniAllowance
        self.UniDeposit=UniDeposit
    
  def save(self):
    sql = "insert into Receivables (FieldEmpID, CholFund, EmpFileFund, HolidayPay, ThirteenMonthPay, IncentivesPay, UniAllowance, UniDeposit) values (%s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.FieldEmpID, self.CholFund, self.EmpFileFund, self.HolidayPay, self.ThirteenMonthPay, self.IncentivesPay, self.UniAllowance, self.UniDeposit)
    db.ins(sql,params)
    
  def get(prop):
    sql = "select %s from Receivables where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update Receivables set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
    