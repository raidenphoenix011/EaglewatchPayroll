import db

class ManHourLogs(object):

  def __init__(self, ID, DetachID, NoOfFullDays, NightHours, RegHours, OTHours, LegHolidayHours, SpeHolidayHours, BirthDate):
    self.ID = ID
    self.DetachID = DetachID
    self.NoOfFullDays = NoOfFullDays
    self.NightHours = NightHours
    self.RegHours = RegHours
    self.OTHours = OTHours
    self.LegHolidayHours = LegHolidayHours
    self.SpeHolidayHours = SpeHolidayHours
    self.DateCreated = DateCreated
    self.PeriodCode = PeriodCode

  def save(self):
    sql = "insert into ManHourLogs (ID, DetachID, NoOfFullDays, NightHours, RegHours, OTHours, LegHolidayHours, SpeHolidayHours, DateCreated, PeriodCode) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.ID, self.DetachID, self.NoOfFullDays, self.NightHours, self.RegHours, self.OTHours, self.LegHolidayHours, self.SpeHolidayHours, self.DateCreated, self.PeriodCode)
    return db.ins(sql, params)

  def get(prop):
    sql = "select %s from ManHourLogs where ID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update ManHourLogs set %s = %s where ID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)
