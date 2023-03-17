from app import app
from flask import request, make_response, jsonify
from dbhelpers import run_statement
from validhelpers import check_data
import json
import requests
import bcrypt
import time

# Make 2 separate procedures for this one. One that selects the id, password
# Then decrypts it in PYTHON
# Once verifies it logs in the user
@app.post('/api/clients-session')
def insert_client_login():
    required_data = ['email', 'password',]
    check_result = check_data(request.json, required_data)
    if check_result != None:
        return check_result
    email = request.json.get('email')
    password = request.json.get('password')
    result = run_statement("CALL get_login_step1(?)", [email])
    if isinstance(result, list) and len(result) > 0 and len(result[0]) > 0:
        client_id_value = result[0][0]
        hashed_password = result[0][1]
        if (bcrypt.checkpw(password.encode(), hashed_password.encode())):
            result2 = run_statement("CALL verify_login_step2(?)", [client_id_value])
            if isinstance(result2, list):
                response = {
                            'clientId' : result2[0][0],
                            'token' : result2[0][1],
                }
                print("New Client-login session recorded in DB!")
                return json.dumps(response, default=str)
            else:
                return "Sorry, something went wrong"
        else:
            return "Invalid email or password"
    else:
        return "Invalid email or password"
    

@app.delete('/api/clients-session')
def delete_client_login():
    check_result = check_data(request.headers, ['token'])
    if check_result != None:
        return check_result
    token = request.headers.get('token')
    client_id_input = request.json.get("clientId")
    result_verify = run_statement("CALL verify_del_login_step1(?,?)", [client_id_input, token])
    print(result_verify)
    if result_verify[0][0] == 1:
        result = run_statement("CALL del_login_step2(?)", [token])
        if result == None:
            return make_response(jsonify("Successfully deleted Client login-session"), 200)
        else:
            return make_response(jsonify("Failed to delete Client login-session. Something went wrong"), 500)
    else:
        return "Invalid credentials. Denied access!"