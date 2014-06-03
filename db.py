import MySQLdb, hashlib, cgi, cgitb; cgitb.enable()
import FieldEmployees, Clients, Detachments

mysql = MySQLdb.connect('localhost','AdminPayroll','Password','Eaglewatch')
cur = mysql.cursor()

def getOne(sql, params):
  try: 
    cur.execute(sql, params)
    res = cur.fetchone()
    return res[0]
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    #print 'Error retrieving data from the database'
    return None

def set(sql, params):
  try: 
    cur.execute(sql, params)
    res = cur.fetchall()
    return res[0]
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    #print 'Error retrieving data from the database'
    return None

def ins(sql, params):
  try: 
    cur.execute(sql, params)
    res = cur.fetchall()
    return res[0]
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
  sql = "SELECT * FROM %s where %s = %s" % (tableName, foreignKey, value)
  res = getAll(sql)
  return res

def getAllFieldEmployees():
  sql = "SELECT f.ID, ft.Description, f.FECode, f.DisplayCode, f.Suffix, f.LastName, f.FirstName, f.MiddleName, f.Landline, f.MobileNo, f.Address, f.BirthDate, f.Gender, f.CivilStatus, f.Dependents,f.Skills, f.DateHired, f.DateResigned, f.FieldEmpStatus, f.CholStatus, f.FileStatus FROM FieldEmployees f INNER JOIN FieldEmployeeTypes ft ON f.Type = ft.Type WHERE f.ID = 1;"
  res = getAll(sql)
  #res = List("FieldEmployees")
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
      Client = Clients.Clients( int(row[0]), str(row[1]), str(row[2]), str(row[3]), str(row[4]), str(row[5]) )
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