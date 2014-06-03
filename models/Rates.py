import db

class Rates(object):

  def __init__(self, ClientID, RateID, Code, Name, Address, StartDate, EndDate, Status):
    self.ID = ID
    self.RateType = RateType
    self.HolidayType = HolidayType
    self.IncentiveType = IncentiveType
    self.Regular = Regular
    self.Overtime = Overtime
    self.NDifferential = NDifferential
    self.ECOLA = ECOLA
    self.ThirteenMonth = ThirteenMonth
    self.PhilHealth = PhilHealth
    self.PagibigPrem = PagibigPrem
    self.Incentive = Incentive
    self.LegalHoliday = LegalHoliday
    self.SpecialHoliday = SpecialHoliday
    self.EffectiveDate = EffectiveDate

  def save(self):
    #sql = "insert into Rates (RateType, HolidayType, IncentiveType, Regular, Overtime, NDifferential, ECOLA, ThirteenMonth, PhilHealth, PagibigPrem, Incentive, LegalHoliday, EffectiveDate) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    sql = "insert into Rates values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    params = (self.RateType, self.HolidayType, self.Incentive, self.Regular, self.Overtime, self.NDifferential, self.ECOLA, self.ThirteenMonth, self.PhilHealth, self.PagibigPrem, self.Incentive, self.LegalHoliday, self.EffectiveDate)
    return db.ins(sql, params)

  def get(prop):
    sql = "select %s from Rates where ID = %s"
    params = (prop, self.ID)
    return db.getOne(sql, params)

  def set(prop, val):
    sql = "update Rates set %s = %s where ID = %s"
    params = (prop, val, self.ID)
    return db.set(sql, params)

