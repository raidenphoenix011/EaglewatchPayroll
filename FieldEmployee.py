

class FieldEmployee(object):

  def __init__(self, ID, Type, DisplayCode, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, Address, Birthdate, Gender, CivilStatus, Dependents, Skills, DateHired, DateResigned, EmpStatus, CholesterolStatus, FileStatus):
    self.ID = ID 
    self.type=Type
    self.DisplayCode=DisplayCode
    self.Suffix=Suffix
    self.LastName=LastName
    self.FirstName=FirstName
    self.MiddleName=MiddleName
    self.Landline=Landline
    self.MobileNo=MobileNo
    self.Address=Address
    self.Birthdate=Birthdate
    self.Gender=Gender
    self.CivilStatus=CivilStatus
    self.Dependents=Dependents
    self.Skills=Skills
    self.Datehired=DateHired
    self.Dateresigned=DateResigned
    self.EmpStatus=EmpStatus
    self.CholesterolStatus=CholesterolStatus
    self.FileStatus=FileStatus
  
  def save(self):
    sql = "insert into FieldEmployees (Type, DisplayCode, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, Address, Birthdate, Gender, CivilStatus, Dependents, Skills, DateHired, DateResigned, EmpStatus, CholesterolStatus, FileStatus) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.type, self.DisplayCode, self.Suffix, self.LastName, self.FirstName, self.MiddleName, self.Landline, self.MobileNo, self.Address, self.Birthdate, self.Gender, self.CivilStatus, self.Dependents, self.Skills, self.Datehired, self.DateResigned, self.EmpStatus, self.CholesterolStatus, self.Filestatus)
    db.ins(sql,params)
    
  def get(prop):
    sql = "select * from FieldEmployees where ID=1"
    return db.getOne(sql)
    
  def set(prop, val):
    sql = "update FieldEmployees set %s=%s where DisplayCode = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)
  
  def getAll():
    sql = "select * from FieldEmployees"
    return db.getAll(sql)