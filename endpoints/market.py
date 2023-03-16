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
@app.post('/api/market-coin')
def make_market():
    # response = requests.get("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h")
        data = request.get_json()
        # BTC Parameters
        image_value = data.get('image')
        ath_value = data.get('ath')
        atl_value = data.get('atl')
        cur_price_value = data.get('current_price')
        market_cap_value = data.get('market_cap')
        market_cap_rank_value = data.get('market_cap_rank')
        name_value = data.get('name')
        total_supply_value = data.get('total_supply')
        total_volume_value = data.get('total_volume')
        #Adding the ETH parameters
        image_value_eth = data.get('imageEth')
        ath_value_eth = data.get('athEth')
        atl_value_eth = data.get('atlEth')
        cur_price_value_eth = data.get('current_priceEth')
        market_cap_value_eth = data.get('market_capEth')
        market_cap_rank_value_eth = data.get('market_cap_rankEth')
        name_value_eth = data.get('nameEth')
        total_supply_value_eth = data.get('total_supplyEth')
        total_volume_value_eth = data.get('total_volumeEth')
        #Adding the USDT parameters
        image_value_usdt = data.get('imageUsdt')
        ath_value_usdt = data.get('athUsdt')
        atl_value_usdt= data.get('atlUsdt')
        cur_price_value_usdt = data.get('current_priceUsdt')
        market_cap_value_usdt = data.get('market_capUsdt')
        market_cap_rank_value_usdt = data.get('market_cap_rankUsdt')
        name_value_usdt = data.get('nameUsdt')
        total_supply_value_usdt = data.get('total_supplyUsdt')
        total_volume_value_usdt = data.get('total_volumeUsdt')
        #Adding the BNB parameters
        image_value_bnb = data.get('imageBnb')
        ath_value_bnb = data.get('athBnb')
        atl_value_bnb= data.get('atlBnb')
        cur_price_value_bnb = data.get('current_priceBnb')
        market_cap_value_bnb = data.get('market_capBnb')
        market_cap_rank_value_bnb = data.get('market_cap_rankBnb')
        name_value_bnb = data.get('nameBnb')
        total_supply_value_bnb = data.get('total_supplyBnb')
        total_volume_value_bnb = data.get('total_volumeBnb')
        #Adding the LTC parameters
        image_value_ltc = data.get('imageLtc')
        ath_value_ltc = data.get('athLtc')
        atl_value_ltc = data.get('atlLtc')
        cur_price_value_ltc = data.get('current_priceLtc')
        market_cap_value_ltc = data.get('market_capLtc')
        market_cap_rank_value_ltc = data.get('market_cap_rankLtc')
        name_value_ltc = data.get('nameLtc')
        total_supply_value_ltc = data.get('total_supplyLtc')
        total_volume_value_ltc = data.get('total_volumeLtc')
        #Adding the AVAX parameters
        image_value_avax = data.get('imageAvax')
        ath_value_avax = data.get('athAvax')
        atl_value_avax = data.get('atlAvax')
        cur_price_value_avax = data.get('current_priceAvax')
        market_cap_value_avax = data.get('market_capAvax')
        market_cap_rank_value_avax = data.get('market_cap_rankAvax')
        name_value_avax = data.get('nameAvax')
        total_supply_value_avax = data.get('total_supplyAvax')
        total_volume_value_avax = data.get('total_volumeAvax')
        #Adding the MATIC parameters
        image_value_matic = data.get('imageMatic')
        ath_value_matic = data.get('athMatic')
        atl_value_matic= data.get('atlMatic')
        cur_price_value_matic = data.get('current_priceMatic')
        market_cap_value_matic = data.get('market_capMatic')
        market_cap_rank_value_matic = data.get('market_cap_rankMatic')
        name_value_matic = data.get('nameMatic')
        total_supply_value_matic = data.get('total_supplyMatic')
        total_volume_value_matic = data.get('total_volumeMatic')
        #Adding the UNI parameters
        image_value_uni = data.get('imageUni')
        ath_value_uni = data.get('athUni')
        atl_value_uni= data.get('atlUni')
        cur_price_value_uni = data.get('current_priceUni')
        market_cap_value_uni = data.get('market_capUni')
        market_cap_rank_value_uni = data.get('market_cap_rankUni')
        name_value_uni = data.get('nameUni')
        total_supply_value_uni = data.get('total_supplyUni')
        total_volume_value_uni = data.get('total_volumeUni')
        #Adding the SOL parameters
        image_value_sol = data.get('imageSol')
        ath_value_sol = data.get('athSol')
        atl_value_sol= data.get('atlSol')
        cur_price_value_sol = data.get('current_priceSol')
        market_cap_value_sol = data.get('market_capSol')
        market_cap_rank_value_sol = data.get('market_cap_rankSol')
        name_value_sol = data.get('nameSol')
        total_supply_value_sol = data.get('total_supplySol')
        total_volume_value_sol = data.get('total_volumeSol')
        #Adding the DOT parameters
        image_value_dot = data.get('imageDot')
        ath_value_dot = data.get('athDot')
        atl_value_dot= data.get('atlDot')
        cur_price_value_dot = data.get('current_priceDot')
        market_cap_value_dot = data.get('market_capDot')
        market_cap_rank_value_dot = data.get('market_cap_rankDot')
        name_value_dot = data.get('nameDot')
        total_supply_value_dot = data.get('total_supplyDot')
        total_volume_value_dot = data.get('total_volumeDot')
        result = run_statement("CALL test_insert_data_from_gecko(?,?,?,?,?,?,?,?,?)", [image_value, ath_value, atl_value, cur_price_value, market_cap_value, market_cap_rank_value, name_value, total_supply_value, total_volume_value])
        result_eth = run_statement("CALL insert_mkt_eth(?,?,?,?,?,?,?,?,?)", [image_value_eth, ath_value_eth, atl_value_eth, cur_price_value_eth, market_cap_value_eth, market_cap_rank_value_eth, name_value_eth, total_supply_value_eth, total_volume_value_eth])
        result_usdt = run_statement("CALL insert_mkt_usdt(?,?,?,?,?,?,?,?,?)",[image_value_usdt, ath_value_usdt, atl_value_usdt, cur_price_value_usdt, market_cap_value_usdt, market_cap_rank_value_usdt, name_value_usdt, total_supply_value_usdt, total_volume_value_usdt])
        result_bnb = run_statement("CALL insert_mkt_bnb(?,?,?,?,?,?,?,?,?)",[image_value_bnb, ath_value_bnb, atl_value_bnb, cur_price_value_bnb, market_cap_value_bnb, market_cap_rank_value_bnb, name_value_bnb, total_supply_value_bnb, total_volume_value_bnb])
        result_ltc = run_statement("CALL insert_mkt_ltc(?,?,?,?,?,?,?,?,?)", [image_value_ltc, ath_value_ltc, atl_value_ltc, cur_price_value_ltc, market_cap_value_ltc, market_cap_rank_value_ltc, name_value_ltc, total_supply_value_ltc, total_volume_value_ltc])
        result_avax = run_statement("CALL insert_mkt_avax(?,?,?,?,?,?,?,?,?)", [image_value_avax, ath_value_avax, atl_value_avax, cur_price_value_avax, market_cap_value_avax, market_cap_rank_value_avax, name_value_avax, total_supply_value_avax, total_volume_value_avax])
        result_matic = run_statement("CALL insert_mkt_matic(?,?,?,?,?,?,?,?,?)", [image_value_matic, ath_value_matic, atl_value_matic, cur_price_value_matic, market_cap_value_matic, market_cap_rank_value_matic, name_value_matic, total_supply_value_matic, total_volume_value_matic])
        result_uni = run_statement("CALL insert_mkt_uni(?,?,?,?,?,?,?,?,?)", [image_value_uni, ath_value_uni, atl_value_uni, cur_price_value_uni, market_cap_value_uni, market_cap_rank_value_uni, name_value_uni, total_supply_value_uni, total_volume_value_uni])
        result_sol = run_statement("CALL insert_mkt_sol(?,?,?,?,?,?,?,?,?)", [image_value_sol, ath_value_sol, atl_value_sol, cur_price_value_sol, market_cap_value_sol, market_cap_rank_value_sol, name_value_sol, total_supply_value_sol, total_volume_value_sol])
        result_dot = run_statement("CALL insert_mkt_dot(?,?,?,?,?,?,?,?,?)", [image_value_dot, ath_value_dot, atl_value_dot, cur_price_value_dot, market_cap_value_dot, market_cap_rank_value_dot, name_value_dot, total_supply_value_dot, total_volume_value_dot])
        if result is None and result_eth is None and result_usdt is None and result_bnb is None and result_ltc is None and result_avax is None and result_matic is None and result_uni is None and result_sol is None and result_dot is None:
            return data
        else:
            return make_response(jsonify(result), 500)

#Getting lots of failed connections or too many connection errors with my get endpoint
@app.get('/api/market-coin')
def get_market():
    keys = ['images','ath', 'atl', 'current_price', 'market_cap', 'market_cap_rank', 'name', 'total_supply', 'total_volume']
    result = run_statement("CALL get_mkt_data")
    coin_alpha = []
    if (type(result) == list):
        for alpha in result:
            coin_alpha.append(dict(zip(keys, alpha)))
        return make_response(jsonify(coin_alpha), 200)
    else:
        return make_response(jsonify(result), 500)