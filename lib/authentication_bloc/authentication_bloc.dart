import 'dart:async';

import 'package:anet/authentication_bloc/authentication_event.dart';
import 'package:anet/authentication_bloc/authentication_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    print("EVENT:  \n\n\n\n $event\n\n\n\n\n");
    if (event is appStarted) {
      //print("this is happening") ;
      final bool hasToken = await userRepository.hasToken();
      //final bool hasToken = true ;

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        if (event is Register) {
          print("REGISTER BRO");
          yield AuthenticationUnauthenticatedRegister();
        } else {
          yield AuthenticationUnauthenticated();
        }
      }
    }
    if (event is Register) {
      print("REGISTER BRO");
      yield AuthenticationUnauthenticatedRegister();
    }

    if (event is LoggedIn) {
      // yield AuthenticationLoading();

      // await Future.delayed(Duration(milliseconds: 250), () {});
      yield AuthenticationAuthenticated();
    } else if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
