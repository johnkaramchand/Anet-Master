import 'package:anet/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  //Map<String, String> headers = {"Content-type": "application/x-www-form-urlencoded"};
  Map<String, String> headers = {"Content-type": "application/json"};

  Future<LoginResponse> authenticate(
      {@required String username,
      //@required String email,
      @required String password}) async {
    var res;
    var response;
    String jsonRequest =
        '{"email": "${username.trim()}", "password":"$password"}';
    print("THIS IS JSON REQUEST $jsonRequest");
    //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
    // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
    // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;
    try {
      response = await http.post('http://test.ciadev.ninja/rest/login/',
          body: jsonRequest, headers: headers);
      res = json.decode(response.body);

      print("\n\n\n\n\nThis is login response bro  : ");
      print(res);
    } catch (error) {
      print("Something went wrong");
    }
    print("KEY");
    print(res['non_field_errors'][0]);

    if ((res['non_field_errors'][0] == 'User account is disabled.')) {
      LoginResponse loginResponse = LoginResponse(status: 'ACTIVATE');
      return loginResponse;
    } else if (res['non_field_errors'][0] ==
        'Unable to log in with provided credentials.') {
      LoginResponse loginResponse = LoginResponse(status: 'WRONG');
      return loginResponse;
    } else if (res['non_field_errors'][0] == 'NONE') {
      LoginResponse loginResponse = LoginResponse.fromJson(res);
      return loginResponse;
      // persistToken(response['key']);

    }

    // return LoginResponse(
    //   username: '', email: '', status: 'failed', key: 'null');
  }

  Future<String> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    final tokenkey = 'communitiesinatria-token';
    final usernamekey = 'communitiesinatria-username';
    final emailkey = 'communitiesinatria-email';

    prefs.remove(tokenkey);
    prefs.remove(usernamekey);
    prefs.remove(emailkey);
  }

  Future<void> persistToken(LoginResponse loginResponse) async {
    // await Future.delayed(Duration(seconds: 1)) ;
    //  return ;
    final prefs = await SharedPreferences.getInstance();
    final tokenkey = 'communitiesinatria-token';
    final usernamekey = 'communitiesinatria-username';
    final emailkey = 'communitiesinatria-email';
    //final value = token;

    prefs.setString(tokenkey, loginResponse.key);
    prefs.setString(usernamekey, loginResponse.username);
    prefs.setString(emailkey, loginResponse.email);
    print('saved $loginResponse');
  }

  Future<bool> hasToken() async {
    //await Future.delayed(Duration(seconds: 1)) ;
    //return false;
    final prefs = await SharedPreferences.getInstance();
    final key = 'communitiesinatria-token';
    final value = prefs.getString(key) ?? 'false';
    print('read: $value');
    if (value != 'false') {
      return true;
    }
    return false;
  }

  getToken() async {
    //await Future.delayed(Duration(seconds: 1)) ;
    //return false;
    final prefs = await SharedPreferences.getInstance();
    final key = 'communitiesinatria-token';
    final value = prefs.getString(key) ?? 'false';
    print('read: $value');
    if (value != 'false') {
      return '$value';
    }
    return '$value';
  }

  Future<LoginResponse> register(
      {@required String username,
      @required String email,
      @required String password1,
      @required String password2,
      @required String usn,
      @required int dept,
      @required int ut_id,
      @required String phone_number}) async {
    var response;
    var res;
    String jsonRequest =
        '{"username": "${username.trim()}", "password1":"${password1.trim()}", "password2":"${password2.trim()}","email":"${email.trim()}","usn":"${usn.trim()}","dept":"$dept","ut_id":"$ut_id","phone_number":"${phone_number.trim()}"}';
    //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
    // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
    // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;
    print("SURYA THIS IS THE DATA : $jsonRequest");

    try {
      print("STHIS IS THE DATA : $jsonRequest");
      response = await http.post('http://test.ciadev.ninja/rest/register/',
          body: jsonRequest, headers: headers);
      res = json.decode(response.body);
    } catch (error) {}
    print("KEY: $res");
    if (res['status'] != null) {
      LoginResponse loginResponse = LoginResponse.fromJson(res);
      return loginResponse;
      // persistToken(response['key']);

    }
  }
}
