import db

    
class PayrollRecord(object):
  def __init__(self, MHLogID, UniDepoID, SSSLoanID, CalamityLoanID, SalaryLoanID, AllowanceID, Regular, Overtime, NDifferential, ECOLA, LegalHoliday, SpecialHoliday, NetPays):
        
        self.MHLogID=MHLogID 
        self.UniDepoID=UniDepoID
        self.SSSLoanID=SSSLoanID
        self.CalamityLoanID=CalamityLoanID
        self.SalaryLoanID=SalaryLoanID
        
        self.AllowanceID=AllowanceID
        self.Regular=Regular
        self.Overtime=Overtime
        self.NDifferential=NDifferential
        self.ECOLA=ECOLA
        
        self.LegalHoliday=LegalHoliday
        self.SpecialHoliday=SpecialHoliday
        self.NetPays=NetPays
    
  def save(self):
    sql = "insert into PayrollRecord (MHLogID, UniDepoID, SSSLoanID, CalamityLoanID, SalaryLoanID, AllowanceID, Regular, Overtime, NDifferential, ECOLA, LegalHoliday, SpecialHoliday, NetPays) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.MHLogID, self.UniDepoID, self.SSSLoanID, self.CalamityLoanID, self.SalaryLoanID, self.AllowanceID, self.Regular, self.Overtime, self.NDifferential, self.ECOLA, self.LegalHoliday, self.SpecialHoliday, self.NetPays)
    db.ins(sql,params)
    

  def get(prop):
    sql = "select %s from PayrollRecord where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update PayrollRecord set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
