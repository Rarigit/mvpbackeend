from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests
import bcrypt

#In Vue make this the register page*
#Tested
@app.get('/api/clients')
def get_client():
    keys = ['username', 'first_name', 'last_name', 'email', 'client_id']
    token_input = request.headers.get("token")
    result = run_statement("CALL get_clients_tkarg(?)", [token_input])
    client_alpha = []
    if (type(result) == list):
        for client in result:
            client_alpha.append(dict(zip(keys, client)))
        return make_response(jsonify(client_alpha), 200)
    else:
        return make_response(jsonify(result), 500)
    
#Tested
@app.post('/api/clients')
def insert_client():
    required_data = ['userName', 'firstName', 'lastName', 'email', 'password']
    check_result = check_data(request.json, required_data)
    if check_result != None:
        return check_result
    username = request.json.get('userName')
    first_name = request.json.get('firstName')
    last_name = request.json.get('lastName')
    email = request.json.get('email')
    password = request.json.get('password')
    salt = bcrypt.gensalt(rounds=12)
    hash_result = bcrypt.hashpw(password.encode(), salt)
    result = run_statement("CALL insert_clients(?,?,?,?,?)", [username, first_name, last_name, email, hash_result])
    if (type(result) == list):
        response = {
                        'clientId' : result[0][0],
                        'token' : result[0][1],
        }
        print("New client recorded in DB!")
        return json.dumps(response, default=str)
    else:
        return "Sorry, something went wrong."


#Tested
@app.patch('/api/clients')
def patch_client():
    required_data = ['token']
    check_result = check_data(request.headers, required_data)
    if check_result != None:
        return check_result
    token_input = request.headers.get("token")
    password = request.json.get('password')
    salt = bcrypt.gensalt(rounds=12)
    hash_result = bcrypt.hashpw(password.encode(), salt)
    username = request.json.get('userName')
    first_name = request.json.get('firstName')
    last_name = request.json.get('lastName')
    result = run_statement("CALL edit_clients(?,?,?,?,?)", [token_input, hash_result, username, first_name, last_name])
    if result == None:
        return make_response(jsonify("Client info updated successfully"), 200)
    else:
        return make_response(jsonify("Update failed. Something went wrong"), 500)

#Tested deletes client login and clients
@app.delete('/api/clients')
def delete_client():
    check_result = check_data(request.headers, ['token'])
    if check_result != None:
        return check_result
    token = request.headers.get('token')
    client_id_input = request.json.get('clientId')
    result_verify = run_statement("CALL verify_del_clients(?,?)", [client_id_input, token])
    print(result_verify)
    if result_verify[0][0] == 1:
        result = run_statement("CALL delete_clients(?)", [token])
        if result == None:
            return make_response(jsonify("Successfully deleted client"), 200)
        else:
            return make_response(jsonify("Failed to delete client. Something went wrong"), 500)
    else:
        return "Credential Authentication failed. Error!"
    