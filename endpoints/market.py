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
        # BTC Parameters
        ath_value = data.get('ath')
        atl_value = data.get('atl')
        cur_price_value = data.get('current_price')
        market_cap_value = data.get('market_cap')
        market_cap_rank_value = data.get('market_cap_rank')
        name_value = data.get('name')
        total_supply_value = data.get('total_supply')
        total_volume_value = data.get('total_volume')
        #Adding the ETH parameters 
        ath_value_eth = data.get('athEth')
        atl_value_eth = data.get('atlEth')
        cur_price_value_eth = data.get('current_priceEth')
        market_cap_value_eth = data.get('market_capEth')
        market_cap_rank_value_eth = data.get('market_cap_rankEth')
        name_value_eth = data.get('nameEth')
        total_supply_value_eth = data.get('total_supplyEth')
        total_volume_value_eth = data.get('total_volumeEth')
        #Adding the USDT parameters
        ath_value_usdt = data.get('athUsdt')
        atl_value_usdt= data.get('atlUsdt')
        cur_price_value_usdt = data.get('current_priceUsdt')
        market_cap_value_usdt = data.get('market_capUsdt')
        market_cap_rank_value_usdt = data.get('market_cap_rankUsdt')
        name_value_usdt = data.get('nameUsdt')
        total_supply_value_usdt = data.get('total_supplyUsdt')
        total_volume_value_usdt = data.get('total_volumeUsdt')
        #Adding the BNB parameters
        ath_value_bnb = data.get('athBnb')
        atl_value_bnb= data.get('atlBnb')
        cur_price_value_bnb = data.get('current_priceBnb')
        market_cap_value_bnb = data.get('market_capBnb')
        market_cap_rank_value_bnb = data.get('market_cap_rankBnb')
        name_value_bnb = data.get('nameBnb')
        total_supply_value_bnb = data.get('total_supplyBnb')
        total_volume_value_bnb = data.get('total_volumeBnb')
        #Adding the XRP parameters
        ath_value_xrp = data.get('athXrp')
        atl_value_xrp = data.get('atlXrp')
        cur_price_value_xrp = data.get('current_priceXrp')
        market_cap_value_xrp = data.get('market_capXrp')
        market_cap_rank_value_xrp = data.get('market_cap_rankXrp')
        name_value_xrp = data.get('nameXrp')
        total_supply_value_xrp = data.get('total_supplyXrp')
        total_volume_value_xrp = data.get('total_volumeXrp')
        #Adding the ADA parameters
        ath_value_ada = data.get('athAda')
        atl_value_ada = data.get('atlAda')
        cur_price_value_ada = data.get('current_priceAda')
        market_cap_value_ada = data.get('market_capAda')
        market_cap_rank_value_ada = data.get('market_cap_rankAda')
        name_value_ada = data.get('nameAda')
        total_supply_value_ada = data.get('total_supplyAda')
        total_volume_value_ada = data.get('total_volumeAda')
        #Adding the MATIC parameters
        ath_value_matic = data.get('athMatic')
        atl_value_matic= data.get('atlMatic')
        cur_price_value_matic = data.get('current_priceMatic')
        market_cap_value_matic = data.get('market_capMatic')
        market_cap_rank_value_matic = data.get('market_cap_rankMatic')
        name_value_matic = data.get('nameMatic')
        total_supply_value_matic = data.get('total_supplyMatic')
        total_volume_value_matic = data.get('total_volumeMatic')
        #Adding the DOGE parameters
        ath_value_doge = data.get('athDoge')
        atl_value_doge= data.get('atlDoge')
        cur_price_value_doge = data.get('current_priceDoge')
        market_cap_value_doge = data.get('market_capDoge')
        market_cap_rank_value_doge = data.get('market_cap_rankDoge')
        name_value_doge = data.get('nameDoge')
        total_supply_value_doge = data.get('total_supplyDoge')
        total_volume_value_doge = data.get('total_volumeDoge')
        #Adding the SOL parameters
        ath_value_sol = data.get('athSol')
        atl_value_sol= data.get('atlSol')
        cur_price_value_sol = data.get('current_priceSol')
        market_cap_value_sol = data.get('market_capSol')
        market_cap_rank_value_sol = data.get('market_cap_rankSol')
        name_value_sol = data.get('nameSol')
        total_supply_value_sol = data.get('total_supplySol')
        total_volume_value_sol = data.get('total_volumeSol')
        #Adding the DOT parameters
        ath_value_dot = data.get('athDot')
        atl_value_dot= data.get('atlDot')
        cur_price_value_dot = data.get('current_priceDot')
        market_cap_value_dot = data.get('market_capDot')
        market_cap_rank_value_dot = data.get('market_cap_rankDot')
        name_value_dot = data.get('nameDot')
        total_supply_value_dot = data.get('total_supplyDot')
        total_volume_value_dot = data.get('total_volumeDot')
        result = run_statement("CALL test_insert_data_from_gecko(?,?,?,?,?,?,?,?)", [ath_value, atl_value, cur_price_value, market_cap_value, market_cap_rank_value, name_value, total_supply_value, total_volume_value])
        result_eth = run_statement("CALL insert_mkt_eth(?,?,?,?,?,?,?,?)", [ath_value_eth, atl_value_eth, cur_price_value_eth, market_cap_value_eth, market_cap_rank_value_eth, name_value_eth, total_supply_value_eth, total_volume_value_eth])
        result_usdt = run_statement("CALL insert_mkt_usdt(?,?,?,?,?,?,?,?)",[ath_value_usdt, atl_value_usdt, cur_price_value_usdt, market_cap_value_usdt, market_cap_rank_value_usdt, name_value_usdt, total_supply_value_usdt, total_volume_value_usdt])
        result_bnb = run_statement("CALL insert_mkt_bnb(?,?,?,?,?,?,?,?)",[ath_value_bnb, atl_value_bnb, cur_price_value_bnb, market_cap_value_bnb, market_cap_rank_value_bnb, name_value_bnb, total_supply_value_bnb, total_volume_value_bnb])
        result_xrp = run_statement("CALL insert_mkt_xrp(?,?,?,?,?,?,?,?)", [ath_value_xrp, atl_value_xrp, cur_price_value_xrp, market_cap_value_xrp, market_cap_rank_value_xrp, name_value_xrp, total_supply_value_xrp, total_volume_value_xrp])
        result_ada = run_statement("CALL insert_mkt_ada(?,?,?,?,?,?,?,?)", [ath_value_ada, atl_value_ada, cur_price_value_ada, market_cap_value_ada, market_cap_rank_value_ada, name_value_ada, total_supply_value_ada, total_volume_value_ada])
        result_matic = run_statement("CALL insert_mkt_matic(?,?,?,?,?,?,?,?)", [ath_value_matic, atl_value_matic, cur_price_value_matic, market_cap_value_matic, market_cap_rank_value_matic, name_value_matic, total_supply_value_matic, total_volume_value_matic])
        result_doge = run_statement("CALL insert_mkt_doge(?,?,?,?,?,?,?,?)", [ath_value_doge, atl_value_doge, cur_price_value_doge, market_cap_value_doge, market_cap_rank_value_doge, name_value_doge, total_supply_value_doge, total_volume_value_doge])
        result_sol = run_statement("CALL insert_mkt_sol(?,?,?,?,?,?,?,?)", [ath_value_sol, atl_value_sol, cur_price_value_sol, market_cap_value_sol, market_cap_rank_value_sol, name_value_sol, total_supply_value_sol, total_volume_value_sol])
        result_dot = run_statement("CALL insert_mkt_dot(?,?,?,?,?,?,?,?)", [ath_value_dot, atl_value_dot, cur_price_value_dot, market_cap_value_dot, market_cap_rank_value_dot, name_value_dot, total_supply_value_dot, total_volume_value_dot])
        if result is None and result_eth is None and result_usdt is None and result_bnb is None and result_xrp is None and result_ada is None and result_matic is None and result_doge is None and result_sol is None and result_dot is None:
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