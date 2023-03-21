from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests

@app.get('/api/portfolio')
def get_portfolio():
    keys = ['client_id', 'name', 'quantity', 'purchase_price', 'current_price']
    token_input = request.headers.get("token")
    result = run_statement("CALL get_folio_data(?)", [token_input])
    port_alpha = []
    if (type(result) == list):
        for port in result:
            port_alpha.append(dict(zip(keys, port)))
        return make_response(jsonify(port_alpha), 200)
    else:
        return make_response(jsonify(result), 500)
    

@app.post('/api/portfolio')
def insert_portfolio():
    required_data = ['clientId', 'name', 'purchasePrice', 'quantity', 'clientEmail']
    check_result = check_data(request.json, required_data)
    if check_result != None:
        return check_result
    client_id_input = request.json.get('clientId')
    name_input = request.json.get('name')
    purchase_price = request.json.get('purchasePrice')
    result_verify = run_statement("CALL check_purc_price(?,?)", [name_input, purchase_price])
    if result_verify[0][0] == 1:
        quantity_input = request.json.get('quantity')
        client_email_input = request.json.get('clientEmail')
        result = run_statement("CALL insert_folio_data(?,?,?,?,?)", [client_id_input, name_input, quantity_input, purchase_price, client_email_input])
        if (type(result) == list):
            response = {
                            'portId' : result[0][0],
            }
            print("New client recorded in DB!")
            return json.dumps(response, default=str)
        else:
            return "Sorry, something went wrong."
    else:
        return "SQL Error: Purchase price is above ATH. Try again."


@app.patch('/api/portfolio')
def patch_portfolio():
    required_data = ['portId']
    check_result = check_data(request.headers, required_data)
    if check_result != None:
        return check_result
    id_input = request.headers.get("portId")
    name_input = request.json.get('name')
    purchase_price_input = request.json.get('purchasePrice')
    quantity_input = request.json.get('quantity')
    result = run_statement("CALL edit_folio_data(?,?,?,?)", [id_input, name_input, purchase_price_input, quantity_input])
    if result == None:
        return make_response(jsonify("Client info updated successfully"), 200)
    else:
        return make_response(jsonify("Update failed. Something went wrong"), 500)
    

@app.delete('/api/portfolio')
def delete_portfolio():
    check_result = check_data(request.headers, ['portId'])
    if check_result != None:
        return check_result
    id_input = request.headers.get('portId')
    result_verify = run_statement("CALL verify_del_folio(?)", [id_input])
    print(result_verify)
    if result_verify[0][0] == 1:
        result = run_statement("CALL del_folio_data(?)", [id_input])
        if result == None:
            return make_response(jsonify("Successfully deleted portfolio"), 200)
        else:
            return make_response(jsonify("Failed to delete client. Something went wrong"), 500)
    else:
        return "Credential Authentication failed. Error!"
    