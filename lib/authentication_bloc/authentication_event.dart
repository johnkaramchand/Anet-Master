import 'package:anet/models/login_response.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class appStarted extends AuthenticationEvent {
  @override
  String toString() => 'App Started';
}

class LoggedIn extends AuthenticationEvent {
  final LoginResponse loginResponse;
  LoggedIn({@required this.loginResponse}) : super([loginResponse]);
  @override
  String toString() => 'Logged In {token: $loginResponse}';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}

class Register extends AuthenticationEvent {
  @override
  String toString() => 'Logged Out';
}
