from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests

#BTC endpoint successfully generated to tables via 3rd party api
@app.get('/api/market-btc')
def get_market():
    response = requests.get("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h")
    data = response.json()
    btc = data[00]
    ath_value = btc.get('ath')
    atl_value = btc.get('atl')
    cur_price_value = btc.get('current_price')
    circ_supply_value = btc.get('circulating_supply')
    market_cap_rank_value = btc.get('market_cap_rank')
    name_value = btc.get('name')
    total_supply_value = btc.get('total_supply')
    result = run_statement("CALL test_insert_data_from_gecko(?,?,?,?,?,?,?)", [ath_value, atl_value, cur_price_value, circ_supply_value, market_cap_rank_value, name_value, total_supply_value])
    if result == None:
        return btc
    else:
        return make_response(jsonify(result), 500)
    
