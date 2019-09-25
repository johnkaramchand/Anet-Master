import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class RegistrationDone extends LoginState {
  @override
  String toString() {
    return "Registered" ;
  }
}


class RegistrationFailure extends LoginState {
  final String error;

  RegistrationFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}