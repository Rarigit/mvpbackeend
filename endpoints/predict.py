from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests


@app.get('/api/predict')
def get_predict():
    keys = ['client_id', 'created_at', 'predicted_price', 'duration_predict', 'predict_result', 'coin_name']
    token_input = request.headers.get("token")
    result = run_statement("CALL get_predictions(?)", [token_input])
    predict_alpha = []
    if (type(result) == list):
        for predict in result:
            predict_alpha.append(dict(zip(keys, predict)))
        return make_response(jsonify(predict_alpha), 200)
    else:
        return make_response(jsonify(result), 500)


@app.post('/api/predict')
def post_predict():
    client_id_input = request.json.get("clientId")
    predicted_price_input = request.json.get("predictedPrice")
    duration_predict_input = request.json.get("durationPredict")
    coin_input = request.json.get("coin")
    result = run_statement("CALL predict_price(?,?,?,?)", [client_id_input, predicted_price_input, duration_predict_input, coin_input])
    if (type(result) == list):
        response = {
                'predict_result' : result[0][0],
        }
        print("New prediction recorded in DB")
        return json.dumps(response, default=str)
    else:
        return "Sorry, something went wrong. Prediction failed to insert"

