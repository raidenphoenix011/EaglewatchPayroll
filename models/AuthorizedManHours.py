import db

class AuthorizedManHours(object):

  def __init__(self, DetachID, Suffix, LastName, FirstName, MiddleName, Landline, MobileNo, BirthDate):
    self.ID = ID
    self.DetachID = DetachID
    self.WorkingDays = WorkingDays
    self.Saturdays = Saturdays
    self.Holidays = Holidays
    self.EffectiveDate = EffectiveDate

  def save(self):
    sql = "insert into DetachmentContactPersons (ID, DetachID, WorkingDays, Saturdays, Holidays, EffectiveDate) values (%s, %s, %s, %s, %s, %s)"
    params = (self.ID, self.DetachID, self.WorkingDays, self.Saturdays, self.Holidays, self.EffectiveDate)
    return db.ins(sql, params)

  def get(prop):
    sql = "select %s from AuthorizedManHours where ID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update AuthorizedManHours set %s = %s where ID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)
