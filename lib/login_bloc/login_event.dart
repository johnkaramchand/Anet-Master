import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  //final String email;
  final String password;
  

  LoginButtonPressed({
    @required this.username,
  //  @required this.email,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class RegisterButtonPressed extends LoginEvent {
  final String username;
  final String email;
  final String password1;
  final String password2;
  final String usn;
  final int dept = 1;
  final int ut_id = 1;
  final String phone_number;



  

  RegisterButtonPressed({
    @required this.username,
    @required this.email,
    @required this.password1,
    @required this.password2,
    @required this.usn,
    //@required this.dept,
    //@required this.ut_id,
    @required this.phone_number
  }) : super([username, email, password1, password2, usn,  phone_number]);

  @override
  String toString() =>
      'RegisterButtonPressed { username: $username, password: $password1 }';
}