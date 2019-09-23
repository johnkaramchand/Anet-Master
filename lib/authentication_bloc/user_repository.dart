import 'package:flutter/material.dart';
/*
class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password 
  }) async {
    await Future.delayed(Duration(seconds: 1)) ;
    return 'token' ;
  }

  Future<String> deleteToken() async {
    await Future.delayed(Duration(seconds: 1)) ;
    return '' ;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1)) ;
    return ;
  }
  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1)) ;
    return false;
  }

}
*/
class UserRepository {
  bool token = false ;
  Future<String> authenticate({
    @required String username,
    @required String password 
  }) async {
    await Future.delayed(Duration(seconds: 1)) ;
    if(username=="john" && password=="john"){
      token = true ;
      return 'token' ;
    }
    return 'nottoken' ;
  }

  Future<String> deleteToken() async {
    await Future.delayed(Duration(seconds: 1)) ;
    return '' ;
  }

  Future<void> persistToken(String token) async {
    await Future.delayed(Duration(seconds: 1)) ;
    return ;
  }
  Future<bool> hasToken() async {
    await Future.delayed(Duration(seconds: 1)) ;
    if(token == true){
      print(token) ;
      return true ;
    }
    else{
      return false;
    }
    
  }

}