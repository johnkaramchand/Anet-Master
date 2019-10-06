import 'package:anet/home/index.dart';
import 'package:anet/login_bloc/signup_form.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';

import 'package:anet/authentication_bloc/authentication.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/login_bloc/login.dart';

class SignupPage extends StatelessWidget {
  static const String routeName = "/signup";
  final UserRepository userRepository;

  SignupPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: 'Signup',
      /*  body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),*/
      body: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(builder: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: userRepository,
            );
          }),
          BlocProvider<HomeBloc>(builder: (context) {
            return HomeBloc(
                // homeBloc: BlocProvider.of<AuthenticationBloc>(context),
                //userRepository: userRepository,
                );
          }),
        ],
        child: SignupForm(),
      ),
    );
  }
}
