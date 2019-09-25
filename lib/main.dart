import 'package:anet/config/index.dart';
import 'package:flutter/material.dart';
import 'package:anet/config/config_page.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';

import 'package:anet/authentication_bloc/authentication.dart';
import 'package:anet/authentication_presentation/splash_screen.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:anet/authentication_presentation/home_page.dart';
import 'package:anet/login_bloc/loading_indicator.dart';
import 'package:flutter/services.dart';
import 'utils/dependency_injection.dart';
import 'utils/devfest.dart';
import 'utils/simple_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anet/login_bloc/signup.dart';


import 'package:flutter/services.dart';
import 'utils/dependency_injection.dart';
import 'utils/devfest.dart';
import 'utils/simple_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {

    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // * Get Shared Preference Instance for whole app
  Devfest.prefs = await SharedPreferences.getInstance();

  //* To check the app is running in debug and set some variables for that
  Devfest.checkDebug();

  //* Time travel debugging to check app states
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // * Set flavor for your app. For eg - MOCK for offline, REST for some random server calls to your backend, FIREBASE for firebase calls
  //* Set DataMode.DART to use Dart hardcoded data and DataMode.JSON to use json file for hardcoded data.
  Injector.configure(Flavor.MOCK, DataMode.JSON);

  
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          //..dispatch(LoggedIn(token: "vlfdnvdfn"));
          ..dispatch(appStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
                  builder: (context) {
                    return LoginBloc(
                      authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
                      userRepository: userRepository,
                    );
                  }
              ),

          ],
          child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            print(state);
            if (state is AuthenticationAuthenticated) {
              return ConfigPage();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            return SplashPage();
          },
        ),
        routes: {SignupPage.routeName: (context) => SignupPage(),},
      ),
    );
  }
}