import 'package:anet/network/i_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anet/network/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserRepository {
    Map<String, String> headers = {"Content-type": "application/json"};
    
    

  Future<String> authenticate({
    @required String username,
    //@required String email,
    @required String password 
  }) async {


  var response ;
    String jsonRequest = '{"username": "$username", "password":"$password"}';
  //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
   // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
   // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;
    try {
          response =  await http.post('http://139.59.61.35:8000/api/v1/rest-auth/login/',
                body:jsonRequest,headers: headers);
          response = json.decode(response.body);
          

    }
    catch(error){

    }
    print("KEY");
          if(response['key']!= null){
           return  response['key'];
           // persistToken(response['key']);
          
          }
          return 'false';
    
    
    
    
      

  }

  Future<String> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
        final key = 'communitiesinatria-token';
      
        prefs.remove(key);
  }

  Future<void> persistToken(String token) async {
   // await Future.delayed(Duration(seconds: 1)) ;
      //  return ;
        final prefs = await SharedPreferences.getInstance();
        final key = 'communitiesinatria-token';
        final value = token;
        prefs.setString(key, value);
        print('saved $value');
      


  }
  Future<bool> hasToken() async {
    //await Future.delayed(Duration(seconds: 1)) ;
    //return false;
    final prefs = await SharedPreferences.getInstance();
        final key = 'communitiesinatria-token';
        final value = prefs.getString(key) ?? 'false';
        print('read: $value');
        if(value != 'false'){
          return true;
        }
        return false;
  }



  Future<String> register({
    @required String username,
    @required String email,
    @required String password1,
    @required String password2,
    @required String usn,
    @required int dept,
    @required int ut_id,
    @required String phone_number
  }) async {


  var response ;
    String jsonRequest = '{"username": "$username", "password1":"$password1", "password2":"$password2","email":"$email","usn":"$usn","dept":"$dept","ut_id":"$ut_id","phone_number":"$phone_number"}';
  //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
   // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
   // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;
    try {
          response =  await http.post('http://139.59.61.35:8000/api/v2/rest-auth/registration/',
                body:jsonRequest,headers: headers);
          response = json.decode(response.body);
          

    }
    catch(error){

    }
    print("KEY");
          if(response['key']!= null){
           return  response['key'];
           // persistToken(response['key']);
          
          }
          return 'false';
    }
    }