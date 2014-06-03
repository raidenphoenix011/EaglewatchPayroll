import db
from flask import Flask, render_template, session, escape, request, redirect, url_for
app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

@app.route('/')
def root():
    return redirect(url_for('login'))

@app.route('/login', methods=['POST', 'GET'])
def login():
  if request.method == 'POST':
    session['user'] = request.form['username']
    user = session['user']
    return redirect(url_for(user))
  return render_template('login.html')

@app.route('/logout')
def logout():
  session.pop('user', None)
  return redirect(url_for('login'))

@app.route('/admin', methods=['POST', 'GET'])
def admin(user=None):
  return render_template('admin.html', user=escape(session['user']))

@app.route('/manhour', methods=['POST', 'GET'])
def manhour(user=None):
  return render_template('manhour.html', user=escape(session['user']))

@app.route('/payroll', methods=['POST', 'GET'])
def payroll(user=None):
    return render_template('payroll.html', user=escape(session['user']))

@app.route('/employees', methods=['POST', 'GET'])
def employees(user=None):
  return render_template('employee_search.html', user=escape(session['user']))

@app.route('/employees/get', methods=['POST', 'GET'])
def  employee(user=None):
  return render_template('employee.html', user=escape(session['user']))

@app.route('/clients', methods=['POST', 'GET'])
def clients(user=None):
  return render_template('client_search.html', user=escape(session['user']))

@app.route('/clients/get', methods=['POST', 'GET'])
def client(user=None):
  return render_template('client.html', user=escape(session['user']))

@app.route('/detachments/get', methods=['POST', 'GET'])
def detachment(user=None):
  return render_template('detachment.html', user=escape(session['user']))

@app.route('/add_manhour', methods=['POST', 'GET'])
def add_manhour(user=None):
  return render_template('detachment_search.html', user=escape(session['user']), navtitle='MANHOUR RECORDS', mode='manhour')

@app.route('/add_payroll', methods=['POST', 'GET'])
def add_payroll(user=None):
  return render_template('detachment_search.html', user=escape(session['user']), navtitle='PAYROLL SYSTEM', mode='payroll')

@app.route('/newfe')
def newfe():
#INSERT INTO ClientContactPersons (ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate) VALUES (1,'','asdsad','asddad','q.','(02)0004567','00000234567 / 00000234567','2009-01-21');
#CALL addFE('SV',1111,'Jr.','Fabularum','Raymond','Maranan','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','Cleared','Cleared')
  sql = "CALL addFE('SV',1111,'Jr.','Fabularum','Raymond','Maranan','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','C','C')"
  #params = (1, 175, "now()", "Active")
  try:
    cur.execute(sql)
    db.commit()
    return redirect(url_for('login'))
  except MySQLdb.Error, e:
    print str(e.args[0]) + ': ' + str(e.args[1])
    #print 'Error retrieving data from the database'
    return redirect(url_for('login'))

@app.route('/gafe')
def gafe():
  return render_template('test.html', FieldEmployees=db.getEmployee(2))

@app.route('/gofe')
def gofe():
  db.getOneFieldEmployee()

if __name__ == '__main__':
    app.debug = True
    app.run()

