import db

    
class SSSContributions(object):
  def __init__(self, PriceFrom, PriceTo, ER, EE, EffectiveYear):
        
        self.PriceFrom=PriceFrom
        self.PriceTo=PriceTo
        self.ER=ER
        self.EE=EE
        self.EffectiveYear=EffectiveYear
    
  def save(self):
    sql = "insert into SSSContributions (PriceFrom, PriceTo, ER, EE, EffectiveYear) values (%s, %s, %s, %s, %s)"
    params = (self.PriceFrom, self.PriceTo, self.ER, self.EE, self.EffectiveYear)
    db.ins(sql,params)
    

  def get(prop):
    sql = "select %s from SSSContributions where ID=%s"
    params =(prop, self.ID)
    return db.getOne(sql, params)
    
  def set(prop, val):
    sql = "update SSSContributions set %s=%s where ID = %s"
    params =(prop, val, self.ID)
    return db.set(sql,params)



