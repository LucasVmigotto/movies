# -*- coding: utf-8 -*-

__author__ = "Lucas Vidor Migotto"
__date__ = "$Fev 18, 2022 17:29:00 AM$"

from flask import Flask
from flask import jsonify

app = Flask(__name__)


@app.route('/', methods=['GET'])
def movies():
    return jsonify({'message': 'Ok'}), 200
