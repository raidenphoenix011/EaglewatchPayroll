import MySQLdb, hashlib, cgi, cgitb; cgitb.enable()
import import_file, logging
from flask import flash

Allowances = import_file.import_file('models/Allowances.py')
AuthorizedManHours = import_file.import_file('models/AuthorizedManHours.py')
ClientContactPersons = import_file.import_file('models/ClientContactPersons.py')
Clients = import_file.import_file('models/Clients.py')
DetachmentContactPersons = import_file.import_file('models/DetachmentContactPersons.py')
Detachments = import_file.import_file('models/Detachments.py')
FieldEmployees = import_file.import_file('models/FieldEmployees.py')
FieldEmployeeTypes = import_file.import_file('models/FieldEmployeeTypes.py')
HolidayMOR = import_file.import_file('models/HolidayMOR.py')
IncentiveMOR = import_file.import_file('models/IncentiveMOR.py')
Logs = import_file.import_file('models/Logs.py')
ManHourLogs = import_file.import_file('models/ManHourLogs.py')
OfficeEmployees = import_file.import_file('models/OfficeEmployees.py')
OfficeEmployeeTypes = import_file.import_file('models/OfficeEmployeeTypes.py')
PagibigCalamityLoans = import_file.import_file('models/PagibigCalamityLoans.py')
PagibigSalaryLoans = import_file.import_file('models/PagibigSalaryLoans.py')
PayrollRecord = import_file.import_file('models/PayrollRecord.py')
PersonalPayables = import_file.import_file('models/PersonalPayables.py')
Rates = import_file.import_file('models/Rates.py')
RateType = import_file.import_file('models/RateType.py')
Receivables = import_file.import_file('models/Receivables.py')
SSSContributions = import_file.import_file('models/SSSContributions.py')
SSSLoans = import_file.import_file('models/SSSLoans.py')
UniformDeposits = import_file.import_file('models/UniformDeposits.py')

mysql = MySQLdb.connect('localhost','raymond','password','Eaglewatch')
cur = mysql.cursor()

def getOne(sql, params):
  try: 
    cur.execute(sql, params)
    res = cur.fetchone()
    return res
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    #print 'Error retrieving data from the database'
    return None

def getAll(sql):
  try: 
    cur.execute(sql)
    res = cur.fetchall()
    return res
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    #print 'Error retrieving data from the database'
    return None

def List(tableName):
  sql = "SELECT * FROM %s" % tableName
  res = getAll(sql)
  return res

def SubList(tableName, foreignKey, value):
  sql = "SELECT * FROM %s WHERE %s = %s" % (tableName, foreignKey, value)
  res = getAll(sql)
  return res

def checkPW(value):
  try: 
    sql = "SELECT Password FROM OfficeEmployees WHERE Username = " + "'" + value + "'"
    cur.execute(sql)
    res = cur.fetchone()
    List = list()
    for row in res:
      List.append(row)
    List = "".join(List)
    return List
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    return None

def getUserType(username):
  try: 
    sql = "SELECT Type FROM OfficeEmployees WHERE Username = " + "'" + username + "'"
    cur.execute(sql)
    res = cur.fetchone()
    List = list()
    for row in res:
      List.append(row)
    List = "".join(List)
    return List
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    return None

def isUsernameExisting(username, password):
  res = checkPW(username)
  print res
  if res is not None:
    print hashlib.sha1(password).hexdigest()
    if res == hashlib.sha1(password).hexdigest():
      return True
    else:
      return False
  else:
      return False

def login(username, password):
  sql = "SELECT Username, Password FROM OfficeEmployees WHERE Username = %s" % username
  res = cur.execute(sql)
  #Creds = []
  for row in res:
    if row is not None:
      #Creds.append([ str(row[0]), str(row[1]) ])
      if str(hashlib.sha1(password)) == row[1]:
        return 1
      #row = cur.fetchone()
  return None

def getEmployee(val):
  #sql = "SELECT * FROM FieldEmployees"
  #res = getAll(sql)
  res = SubList("FieldEmployees", "ID", val)
  #FieldEmployeeList = []
  for row in res:
    if row is not None:
      #FieldEmployeeList.append([ str(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]), str(row[10]), str(row[11]), str(row[12]), str(row[13]), str(row[14]), str(row[15]), str(row[16]), str(row[17]), str(row[18]), str(row[19]), str(row[20]) ])
      FieldEmployee = FieldEmployees.FieldEmployees( str(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]), str(row[10]), str(row[11]), str(row[12]), str(row[13]), int(row[14]), str(row[15]), str(row[16]), str(row[17]), str(row[18]), str(row[19]), str(row[20]) )
      #FieldEmployeeList.append(FieldEmployee)
      #row = cur.fetchone()
  return FieldEmployee

def getAllFieldEmployees():
  #sql = "SELECT f.ID, ft.Description, f.FECode, f.DisplayCode, f.Suffix, f.LastName, f.FirstName, f.MiddleName, f.Landline, f.MobileNo, f.Address, f.BirthDate, f.Gender, f.CivilStatus, f.Dependents,f.Skills, f.DateHired, f.DateResigned, f.FieldEmpStatus, f.CholStatus, f.FileStatus FROM FieldEmployees f INNER JOIN FieldEmployeeTypes ft ON f.Type = ft.Type ;"
  #res = getAll(sql)
  res = List("FieldEmployees")
  FieldEmployeeList = []
  for row in res:
    if row is not None:
      #FieldEmployeeList.append([ str(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]), str(row[10]), str(row[11]), str(row[12]), str(row[13]), str(row[14]), str(row[15]), str(row[16]), str(row[17]), str(row[18]), str(row[19]), str(row[20]) ])
      FieldEmployee = FieldEmployees.FieldEmployees( str(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]), str(row[10]), str(row[11]), str(row[12]), str(row[13]), int(row[14]), str(row[15]), str(row[16]), str(row[17]), str(row[18]), str(row[19]), str(row[20]) )
      FieldEmployeeList.append(FieldEmployee)
      row = cur.fetchone()
  return FieldEmployeeList

def getAllClients():
  res = List("Clients")
  ClientList = []
  for row in res:
    if row is not None:
      Client = Clients.Clients( int(row[0]), str(row[1]), str(row[2]), str(row[3]))
      ClientList.append(Client)
      row = cur.fetchone()
  return ClientList

def getAllDetachments(val):
  #sql = "SELECT * FROM FieldEmployees"
  #res = getAll(sql)
  res = SubList("Detachments", "ClientID", val)
  DetachmentList = []
  for row in res:
    if row is not None:
      #FieldEmployeeList.append([ str(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]), str(row[10]), str(row[11]), str(row[12]), str(row[13]), str(row[14]), str(row[15]), str(row[16]), str(row[17]), str(row[18]), str(row[19]), str(row[20]) ])
      Detachment = Detachments.Detachments( int(row[0]), int(row[1]), int(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]), str(row[9]) )
      DetachmentList.append(Detachment)
      row = cur.fetchone()
  return DetachmentList

def getClientContactPersons(val):
  res = SubList("ClientContactPersons", "ClientID", val)
  ClientContactPersonsList = []
  for row in res:
    if row is not None:
      ClientContactPerson = ClientContactPersons.ClientContactPersons( int(row[0]), int(row[1]), int(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]) )
      ClientContactPersonsList.append(ClientContactPerson)
      row = cur.fetchone()
  return ClientContactPersonsList


def getDetachmentContactPersons(val):
  res = SubList("DetachmentContactPersons", "DetachID", val)
  DetachmentContactPersonsList = []
  for row in res:
    if row is not None:
      DetachmentContactPerson = DetachmentContactPersons.DetachmentContactPersons( int(row[0]), int(row[1]), int(row[2]), str(row[3]), str(row[4]), str(row[5]), str(row[6]), str(row[7]), str(row[8]) )
      DetachmentContactPersonsList.append(DetachmentContactPerson)
      row = cur.fetchone()
  return DetachmentContactPersonsList