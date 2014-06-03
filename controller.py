from flask import Flask, render_template, session, escape, request, redirect, url_for
app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'

from models import Classs
from views import admin

classs = Classs(1, 'classname', 'teacher', 'yrleve', 'room', 'schedule', 1)
admin(classs.name)



if __name__ == '__main__':
    app.debug = True
    app.run()