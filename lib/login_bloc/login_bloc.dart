import 'dart:async';
import 'dart:math';

import 'package:anet/models/login_response.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';

import 'package:anet/authentication_bloc/authentication.dart';
import 'package:anet/login_bloc/login.dart';
import 'dart:convert';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    print("THIS IS EVENT TYPE : $event");
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        LoginResponse loginResponse = await userRepository.authenticate(
          username: event.username,
          // email: event.email,
          password: event.password,
        );

        if (loginResponse.status == 'false') {
          yield LoginFailure(error: "failed");
        } else {
          authenticationBloc.dispatch(LoggedIn(loginResponse: loginResponse));
          yield LoginInitial();
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    } else if (event is RegisterButtonPressed) {
      print("BUTTON PRESSED !");
      yield LoginLoading();
      try {
        LoginResponse registerResponse = await userRepository.register(
            username: event.username,
            email: event.email,
            password1: event.password1,
            password2: event.password2,
            usn: event.usn,
            dept: event.dept,
            ut_id: event.ut_id,
            phone_number: event.phone_number);
        if (registerResponse.status == 'false') {
          yield RegistrationFailure(error: "failed");
        } else {
          LoginResponse loginResponse = LoginResponse(
              email: registerResponse.email,
              username: registerResponse.username,
              status: registerResponse.status,
              key: registerResponse.key);
          authenticationBloc.dispatch(LoggedIn(loginResponse: loginResponse));
          yield LoginInitial();
        }
      } catch (error) {
        yield RegistrationFailure(error: error.toString());
      }
    }
  }
}
//ThemeDataTween ;
