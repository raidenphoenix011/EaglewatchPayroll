from flask import Flask, render_template, session, escape, request, redirect, url_for
app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

from FieldEmployee import FieldEmployee

@app.route('/')
def root():
    return redirect(url_for('login'))

@app.route('/login', methods=['POST', 'GET'])
def login():
  if request.method == 'POST':
    session['user'] = request.form['username']
    user = session['user']
    if user == 'HR_officer':
        session['usertype'] = 'HR'
        return redirect(url_for('listEmployees'))
    if user == 'billing_officer':
        session['usertype'] = 'BiO'
        return redirect(url_for('listClients'))   
    if user == 'manhour_officer':
        session['usertype'] = 'MO'
        return redirect(url_for('listDetachments'))
    if user == 'payroll_officer':
        session['usertype'] = 'PyO'
        return redirect(url_for('listDetachments'))   
    else:
      return redirect(url_for(user))
  return render_template('login.html')

@app.route('/logout')
def logout():
  session.pop('user', None)
  return redirect(url_for('login'))

@app.route('/admin', methods=['POST', 'GET'])
def admin(user=None):
  return render_template('admin.html', user=escape(session['user']))

@app.route('/employees', methods=['POST', 'GET'])
def listEmployees(user=None):
  field_employee1 = FieldEmployee(1,'SG', 'FE001234', 'Jr.', "D'Agosto", 'Nicholas', 'Smith', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'resigned', 'C', 'E')
  field_employee2 = FieldEmployee(2,'SG', 'FE002345', 'IV', 'Naharis', 'Dario', 'Sunter', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'active', 'C', 'E')
  field_employee3 = FieldEmployee(3,'SV', 'FE003456', 'Jr.', 'Hoult', 'Nick', 'Smith', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'resigned', 'C', 'E')
  field_employee4 = FieldEmployee(4,'SV', 'FE003456', 'Jr.', 'Lannister', 'Jamie', 'Targaryen', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'awol', 'C', 'E')
  field_employees = [field_employee1, field_employee2, field_employee3, field_employee4]
  #field_employees = getAllFieldEmployees()
  return render_template('employee_search.html', FEs = field_employees, user=escape(session['user']))
  
@app.route('/employees/get/<ID>', methods=['POST', 'GET'])
def viewEmployee(ID, user=None):
    #field_employee= getEmployee(ID)
  if ID == '1':
    field_employee = FieldEmployee(1,'SG', 'FE001234', 'Jr.', "D'Agosto", 'Nicholas', 'Smith', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'resigned', 'C', 'E')
  else:
    field_employee = FieldEmployee(1,'SG', 'FE001234', 'Jr.', "Hoult", 'Nicholas', 'Smith', '9323232', '09178287292', 'Commonwealth, Q.C.', '02-03-1989', 'M', 'S', 0, 'driving', '01/02/2014', '', 'resigned', 'C', 'E')
  return render_template('employee.html', FE = field_employee, user=escape(session['user']), )

@app.route('/employees/add', methods=['POST', 'GET'])
def addFieldEmployee(user=None):
  #getMaxID + 1
  field_employee = FieldEmployee('','','','','','','','','','','','','','','','','','','','')
  return render_template('employee.html', FE = field_employee, user=escape(session['user']), )

@app.route('/clients', methods=['POST', 'GET'])
def listClients(user=None):
  return render_template('client_search.html', goto='listDetachments', user=escape(session['user']))

#@app.route('/clients/get/<ID>', methods=['POST', 'GET'])
#def client(ID, user=None):
  #client = getClient(ID)
  #return render_template('client.html',Client = client, user=escape(session['user']))
@app.route('/clients/get', methods=['POST', 'GET'])
def viewClient(user=None):
  return render_template('client.html', user=escape(session['user']))

@app.route('/clients/add', methods=['POST', 'GET'])
def addClient(user=None):
    #getMaxID() + 1
  return render_template('client.html', user=escape(session['user']))

@app.route('/detachments/get', methods=['POST', 'GET'])
def viewDetachment(user=None):
  return render_template('detachment.html', user=escape(session['user']))

@app.route('/manhours/detachments', methods=['POST', 'GET'])
def addManhour(user=None):
  return render_template('detachment_search.html', user=escape(session['user']), navtitle='MANHOUR RECORDS', mode='manhour')

@app.route('/manhour', methods=['POST', 'GET'])
def manhour(user=None):
  return render_template('manhour.html', user=escape(session['user']), dept='manhour')

@app.route('/detachments', methods=['POST', 'GET'])
def listDetachments(user=None):
  if session['usertype']=='BiO':
    return render_template('detachment_search.html', user=escape(session['user']),  goto='viewDetachment',navtitle='CLIENT RECORDS', mode='viewDetachment')
  elif session['usertype'] == 'PyO':
    return render_template('detachment_search.html', user=escape(session['user']), goto='payroll', navtitle='PAYROLL SYSTEM', mode='viewPeriods')
  elif session['usertype'] == 'MO':
    return render_template('detachment_search.html', user=escape(session['user']),  goto='manhour',navtitle='MANHOUR RECORDS', mode='viewPeriods')
  else:
    return render_template('detachment_search.html', user=escape(session['user']), navtitle='NO USER TYPE', mode='viewPeriods')

@app.route('/detachments/<usertype>', methods=['POST', 'GET'])
def listDetachmentsAdmin(usertype, user=None):
  if usertype =='BiO':
    return render_template('detachment_search.html', user=escape(session['user']),  goto='viewDetachment',navtitle='CLIENT RECORDS', mode='viewDetachment')
  elif usertype == 'PyO':
    return render_template('detachment_search.html', user=escape(session['user']), goto='payroll', navtitle='PAYROLL SYSTEM', mode='viewPeriods')
  elif usertype == 'MO':
    return render_template('detachment_search.html', user=escape(session['user']),  goto='manhour',navtitle='MANHOUR RECORDS', mode='viewPeriods')
  else:
    return render_template('detachment_search.html', user=escape(session['user']), navtitle='NO USER TYPE', mode='viewPeriods')

@app.route('/payroll', methods=['POST', 'GET'])
def payroll(user=None):
    return render_template('payroll.html', user=escape(session['user']))

@app.route('/manhour/detachments/get/ID/records', methods=['POST', 'GET'])
def viewPeriods(user=None):
  if session['usertype']=='MO':
    return render_template('period_search.html', user=escape(session['user']))
  if session['usertype']=='PyO':
    return render_template('period_search.html', user=escape(session['user']))
  else:
    return render_template('admin.html', user=escape(session['user']))
if __name__ == '__main__':
    app.debug = True
    app.run()

