from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests


#BTC endpoint successfully generated to tables via 3rd party api
# @app.get('/api/market-btc')
#YES I DID IT. DEBUGGER HELPED SHOW ME THAT I WAS TRYING TO SET THE ALPHA FROM THE BOAT TO A VARIABLE BTC, WHILE INSTEAD IT WAS COMING IN AS DATA. ALWAYS USE DEBUGGER 
# @app.route('/api/market-btc', methods=['GET'])
@app.post('/api/market-btc')
def make_market():
    # response = requests.get("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h")
        data = request.get_json()
        # btc = data[00]
        ath_value = data.get('ath')
        atl_value = data.get('atl')
        cur_price_value = data.get('current_price')
        circ_supply_value = data.get('circulating_supply')
        market_cap_rank_value = data.get('market_cap_rank')
        name_value = data.get('name')
        total_supply_value = data.get('total_supply')
        result = run_statement("CALL test_insert_data_from_gecko(?,?,?,?,?,?,?)", [ath_value, atl_value, cur_price_value, circ_supply_value, market_cap_rank_value, name_value, total_supply_value])
        if result == None:
            return data
        else:
            return make_response(jsonify(result), 500)

@app.get('/api/market-btc')
def get_market():
    keys = ['ath', 'atl', 'current_price', 'circulating_supply', 'market_cap_rank', 'name', 'total_supply']
    result = run_statement("CALL get_btcmkt_data")
    bitcoin_alpha = []
    if (type(result) == list):
        for alpha in result:
            bitcoin_alpha.append(dict(zip(keys, alpha)))
        return make_response(jsonify(bitcoin_alpha), 200)
    else:
        return make_response(jsonify(result), 500)