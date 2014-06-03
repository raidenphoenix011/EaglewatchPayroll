import db

    
class OfficeEmployees(object):
  def __init__(self, Code, Name, BillingAddress, Landline):
        
        self.Type=Type 
        self.Username=Username
        self.Password=Password
        self.Suffix=Suffix
        self.LastName=LastName
        self.FirstName=FirstName
        self.MiddleName=MiddleName
        self.Landline=Landline
        self.MobileNo=MobileNo
        self.Address=Address
        self.BirthDate=BirthDate
        self.Gender=Gender
        self.CivilStatus=CivilStatus
        self.Dependents=Dependents
        self.Position=Position
        self.DateHired=DateHired
        self.DateResigned=DateResigned
        self.EmpStatus=EmpStatus
    
  def save(self):
    sql = "insert into OfficeEmployees (Type, Username, Password, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, Address, BirthDate, Gender, CivilStatus, Dependents, Position, DateHired, DateResigned, EmpStatus) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, )"
    params = (self.Type, self.Username, self.Password, self.Suffix, self.LastName, self.FirstName, self.MiddleName, self.Landline, self.MobileNo, self.Address, self.BirthDate, self.Gender, self.CivilStatus, self.Dependents, self.Position, self.DateHired, self.DateResigned, self.EmpStatus)
    db.ins(sql,params)
    
    
  def getFieldEmployee(ID):
    sql = "select Type, Username, Password, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, Address, BirthDate, Gender, CivilStatus, Dependents, Position, DateHired, DateResigned, EmpStatus from FieldEmployee where ID = %s"
    return db.getOne(sql, ID)
    
  def get(prop):
    sql = "select %s from OfficeEmployees where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update OfficeEmployees set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
