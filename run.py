from app import app
from dbcreds import production_mode
import threading
import time
import requests


#I've used a threading function so that my run.py file can handle both my backend and my bot file within the run file. It works fine in local testing, only issue is that it double post in DB.
# However, whenever I try and get it online. I run into issues with my VM. PM logs show errors, browser hit 503 Axios errors. Its very frustrating. 
# Initially I tried and set the bot as as a seperate PM2 instance but that failed as well.
# I think perhaps the server cannot handle the request load from the api. 

def update_market_coin():
    api_url = 'http://127.0.0.1:5024/api/market-coin'
    while True:
        try:
            response = requests.get(
                "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h")
            data = response.json()
            btc = data[0]
            eth = data[1]
            link = data[20]
            bnb = data[3]
            ltc = data[13]
            avax = data[16]
            matic = data[9]
            uni = data[18]
            sol = data[10]
            dot = data[11]
            #BTC json data parse
            image_value = btc.get('image')
            ath_value = btc.get('ath')
            atl_value = btc.get('atl')
            cur_price_value = btc.get('current_price')
            market_cap_value = btc.get('market_cap')
            market_cap_rank_value = btc.get('market_cap_rank')
            name_value = btc.get('name')
            total_supply_value = btc.get('total_supply')
            total_volume_value = btc.get('total_volume')
            #Eth json data parse
            image_value_eth = eth.get('image')
            ath_value_eth = eth.get('ath')
            atl_value_eth = eth.get('atl')
            cur_price_value_eth = eth.get('current_price')
            market_cap_value_eth = eth.get('market_cap')
            market_cap_rank_value_eth = eth.get('market_cap_rank')
            name_value_eth = eth.get('name')
            total_supply_value_eth = eth.get('total_supply')
            total_volume_value_eth = eth.get('total_volume')
            #LINK json data parse
            image_value_link = link.get('image')
            ath_value_link = link.get('ath')
            atl_value_link= link.get('atl')
            cur_price_value_link = link.get('current_price')
            market_cap_value_link = link.get('market_cap')
            market_cap_rank_value_link = link.get('market_cap_rank')
            name_value_link = link.get('name')
            total_supply_value_link = link.get('total_supply')
            total_volume_value_link = link.get('total_volume')
            #BNB json data parse
            image_value_bnb = bnb.get('image')
            ath_value_bnb = bnb.get('ath')
            atl_value_bnb= bnb.get('atl')
            cur_price_value_bnb = bnb.get('current_price')
            market_cap_value_bnb = bnb.get('market_cap')
            market_cap_rank_value_bnb = bnb.get('market_cap_rank')
            name_value_bnb = bnb.get('name')
            total_supply_value_bnb = bnb.get('total_supply')
            total_volume_value_bnb = bnb.get('total_volume')
            #LTC NEW json data parse
            image_value_ltc = ltc.get('image')
            ath_value_ltc = ltc.get('ath')
            atl_value_ltc= ltc.get('atl')
            cur_price_value_ltc = ltc.get('current_price')
            market_cap_value_ltc = ltc.get('market_cap')
            market_cap_rank_value_ltc = ltc.get('market_cap_rank')
            name_value_ltc = ltc.get('name')
            total_supply_value_ltc = ltc.get('total_supply')
            total_volume_value_ltc = ltc.get('total_volume')
            #AVAX NEW json parse
            image_value_avax = avax.get('image')
            ath_value_avax = avax.get('ath')
            atl_value_avax= avax.get('atl')
            cur_price_value_avax = avax.get('current_price')
            market_cap_value_avax = avax.get('market_cap')
            market_cap_rank_value_avax = avax.get('market_cap_rank')
            name_value_avax = avax.get('name')
            total_supply_value_avax = avax.get('total_supply')
            total_volume_value_avax = avax.get('total_volume')
            #Matic json parse
            image_value_matic = matic.get('image')
            ath_value_matic = matic.get('ath')
            atl_value_matic= matic.get('atl')
            cur_price_value_matic = matic.get('current_price')
            market_cap_value_matic = matic.get('market_cap')
            market_cap_rank_value_matic = matic.get('market_cap_rank')
            name_value_matic = matic.get('name')
            total_supply_value_matic = matic.get('total_supply')
            total_volume_value_matic = matic.get('total_volume')
            #UNI NEW json parse
            image_value_uni = uni.get('image')
            ath_value_uni = uni.get('ath')
            atl_value_uni= uni.get('atl')
            cur_price_value_uni = uni.get('current_price')
            market_cap_value_uni = uni.get('market_cap')
            market_cap_rank_value_uni = uni.get('market_cap_rank')
            name_value_uni = uni.get('name')
            total_supply_value_uni = uni.get('total_supply')
            total_volume_value_uni = uni.get('total_volume')
            #Sol json parse
            image_value_sol = sol.get('image')
            ath_value_sol = sol.get('ath')
            atl_value_sol= sol.get('atl')
            cur_price_value_sol = sol.get('current_price')
            market_cap_value_sol = sol.get('market_cap')
            market_cap_rank_value_sol = sol.get('market_cap_rank')
            name_value_sol = sol.get('name')
            total_supply_value_sol = sol.get('total_supply')
            total_volume_value_sol = sol.get('total_volume')
            #Dot json parse
            image_value_dot = dot.get('image')
            ath_value_dot = dot.get('ath')
            atl_value_dot= dot.get('atl')
            cur_price_value_dot = dot.get('current_price')
            market_cap_value_dot = dot.get('market_cap')
            market_cap_rank_value_dot = dot.get('market_cap_rank')
            name_value_dot = dot.get('name')
            total_supply_value_dot = dot.get('total_supply')
            total_volume_value_dot = dot.get('total_volume')
            alpha = {'image': image_value, 'ath': ath_value, 'atl': atl_value, 'current_price': cur_price_value, 'market_cap': market_cap_value, 'market_cap_rank': market_cap_rank_value, 'name': name_value, 'total_supply': total_supply_value, 'total_volume': total_volume_value,
                'imageEth': image_value_eth, 'athEth': ath_value_eth, 'atlEth': atl_value_eth, 'current_priceEth': cur_price_value_eth, 'market_capEth': market_cap_value_eth, 'market_cap_rankEth': market_cap_rank_value_eth, 'nameEth': name_value_eth, 'total_supplyEth': total_supply_value_eth, 'total_volumeEth': total_volume_value_eth,
                'imageLink': image_value_link, 'athLink': ath_value_link, 'atlUsdt': atl_value_link, 'current_priceLink': cur_price_value_link, 'market_capLink': market_cap_value_link, 'market_cap_rankLink': market_cap_rank_value_link, 'nameLink': name_value_link, 'total_supplyLink': total_supply_value_link, 'total_volumeLink': total_volume_value_link,
                'imageBnb': image_value_bnb, 'athBnb': ath_value_bnb, 'atlBnb': atl_value_bnb, 'current_priceBnb': cur_price_value_bnb, 'market_capBnb': market_cap_value_bnb, 'market_cap_rankBnb': market_cap_rank_value_bnb, 'nameBnb': name_value_bnb, 'total_supplyBnb': total_supply_value_bnb, 'total_volumeBnb': total_volume_value_bnb,
                'imageLtc': image_value_ltc, 'athLtc': ath_value_ltc, 'atlLtc': atl_value_ltc, 'current_priceLtc': cur_price_value_ltc, 'market_capLtc': market_cap_value_ltc, 'market_cap_rankLtc': market_cap_rank_value_ltc, 'nameLtc': name_value_ltc, 'total_supplyLtc': total_supply_value_ltc, 'total_volumeLtc': total_volume_value_ltc,
                'imageAvax': image_value_avax, 'athAvax': ath_value_avax, 'atlAvax': atl_value_avax, 'current_priceAvax': cur_price_value_avax, 'market_capAvax': market_cap_value_avax, 'market_cap_rankAvax': market_cap_rank_value_avax, 'nameAvax': name_value_avax, 'total_supplyAvax': total_supply_value_avax, 'total_volumeAvax': total_volume_value_avax,
                'imageMatic': image_value_matic, 'athMatic': ath_value_matic, 'atlMatic': atl_value_matic, 'current_priceMatic': cur_price_value_matic, 'market_capMatic': market_cap_value_matic, 'market_cap_rankMatic': market_cap_rank_value_matic, 'nameMatic': name_value_matic, 'total_supplyMatic': total_supply_value_matic, 'total_volumeMatic': total_volume_value_matic,
                'imageUni': image_value_uni, 'athUni': ath_value_uni, 'atlUni': atl_value_uni, 'current_priceUni': cur_price_value_uni, 'market_capUni': market_cap_value_uni, 'market_cap_rankUni': market_cap_rank_value_uni, 'nameUni': name_value_uni, 'total_supplyUni': total_supply_value_uni, 'total_volumeUni': total_volume_value_uni,
                'imageSol': image_value_sol, 'athSol': ath_value_sol, 'atlSol': atl_value_sol, 'current_priceSol': cur_price_value_sol, 'market_capSol': market_cap_value_sol, 'market_cap_rankSol': market_cap_rank_value_sol, 'nameSol': name_value_sol, 'total_supplySol': total_supply_value_sol, 'total_volumeSol': total_volume_value_sol,
                'imageDot': image_value_dot, 'athDot': ath_value_dot, 'atlDot': atl_value_dot, 'current_priceDot': cur_price_value_dot, 'market_capDot': market_cap_value_dot, 'market_cap_rankDot': market_cap_rank_value_dot, 'nameDot': name_value_dot, 'total_supplyDot': total_supply_value_dot, 'total_volumeDot': total_volume_value_dot}

            response = requests.post(api_url, json=alpha)
            time.sleep(60)
        except Exception as e:
            print(f"An error occurred while updating market coin: {e}")
            time.sleep(60)
        



if (production_mode == True):
    print("Running server in production mode")
    import bjoern #type:ignore
    threading.Thread(target=update_market_coin).start()
    bjoern.run(app, "0.0.0.0", 5024)
else:
    from flask_cors import CORS
    CORS(app)
    print("Running in testing mode")
    lock = threading.Lock()
    threading.Thread(target=update_market_coin).start()
    app.run(debug=True)