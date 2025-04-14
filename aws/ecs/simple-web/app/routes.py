from flask import render_template
from app import app

import platform
import socket


fqdn = socket.getfqdn()

@app.route('/')
@app.route('/index')
def index():
    return render_template('index.html', fqdn = fqdn)