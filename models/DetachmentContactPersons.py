import db

class DetachmentContactPersons(object):

  def __init__(self, DetachID, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, BirthDate):
    self.DetachID = DetachID
    self.Suffix = Suffix
    self.LastName = LastName
    self.FirstName = FirstName
    self.MiddleName = MiddleName
    self.Landline = Landline
    self.MobileNo = MobileNo
    self.BirthDate = BirthDate

  def save(self):
    sql = "insert into DetachmentContactPersons (DetachID, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, BirthDate) values (%s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.DetachID, self.Suffix, self.LastName, self.FirstName, self.MiddleName, self.Landline, self.MobileNo, self.BirthDate)
    return db.ins(sql, params)

  def get(prop):
    sql = "select %s from DetachmentContactPersons where DetachID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update DetachmentContactPersons set %s = %s where DetachID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)
