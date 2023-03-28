from flask import Flask




app = Flask(__name__)

from endpoints import market, client, client_login, portfolio, predict, bot