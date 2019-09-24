import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';

import 'package:anet/authentication_bloc/authentication.dart';
import 'package:anet/login_bloc/login.dart';

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
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {

        
        final token = await userRepository.authenticate(
          username: event.username,
         // email: event.email,
          password: event.password,
        );
        if(token == 'false'){
           yield LoginFailure(error: "failed");
        }
        else{
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
        }
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
//ThemeDataTween ;