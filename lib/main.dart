import 'package:anet/config/config_bloc.dart';
import 'package:anet/config/index.dart';
import 'package:anet/home/index.dart' as prefix1;
import 'package:anet/login_bloc/loading_indicator.dart' as prefix0;
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
import 'package:anet/attendanceNav/attendancepagescreen.dart';
import 'package:anet/eventsnav/event_details.dart';
import 'package:anet/comingsoon.dart';
import 'package:anet/newsNav/newsPageScreen.dart';
import 'package:anet/newsNav/news_details.dart';
import 'package:anet/projectsNav/projectsPageScreen.dart';
import 'package:anet/rank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/home/home_page.dart';

import 'package:anet/eventsnav/eventsPage.dart';
import 'package:flutter/services.dart';
import 'utils/dependency_injection.dart';
import 'utils/devfest.dart';
import 'utils/simple_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_bloc/loading_indicator.dart';

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
  // BlocSupervisor.delegate = SimpleBlocDelegate();

  // * Set flavor for your app. For eg - MOCK for offline, REST for some random server calls to your backend, FIREBASE for firebase calls
  //* Set DataMode.DART to use Dart hardcoded data and DataMode.JSON to use json file for hardcoded data.
  Injector.configure(Flavor.MOCK, DataMode.JSON);

  BlocSupervisor.delegate = SimpleBlocDelegate();
// final userRepository = UserRepository();
  runApp(
    RepositoryProvider(
      builder: (context) {
        return UserRepository();
      },
      child: BlocProvider<AuthenticationBloc>(
        builder: (context) {
          return AuthenticationBloc(
              userRepository: RepositoryProvider.of<UserRepository>(context))
            //..dispatch(LoggedIn(token: "vlfdnvdfn"));
            ..dispatch(appStarted());
        },
        child: App(),
      ),
    ),
  );
}

class App extends StatefulWidget {
  static const String routeName = "/";
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  //App({Key key, @required this.userRepository}) : super(key: key);

  ConfigBloc configBloc;

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() {
    configBloc = ConfigBloc();
    configBloc.darkModeOn =
        Devfest.prefs.getBool(Devfest.darkModePref) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(builder: (context) {
            return LoginBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: RepositoryProvider.of<UserRepository>(context),
            );
          }),
          BlocProvider<ConfigBloc>(builder: (context) {
            return ConfigBloc();
          }),
        ],
        child: BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              //* Custom Google Font
              fontFamily: Devfest.google_sans_family,
              primarySwatch: Colors.red,
              primaryColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              disabledColor: Colors.grey,
              cardColor: configBloc.darkModeOn ? Colors.black : Colors.white,
              canvasColor:
                  configBloc.darkModeOn ? Colors.black : Colors.grey[40],
              brightness:
                  configBloc.darkModeOn ? Brightness.dark : Brightness.light,
              buttonTheme: Theme.of(context).buttonTheme.copyWith(
                  colorScheme: configBloc.darkModeOn
                      ? ColorScheme.dark()
                      : ColorScheme.light()),
              appBarTheme: AppBarTheme(
                elevation: 0.0,
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                print(state);
                if (state is AuthenticationAuthenticated) {
                  return ConfigPage();
                }
                if (state is AuthenticationUnauthenticated) {
                  return LoginPage(
                      userRepository:
                          RepositoryProvider.of<UserRepository>(context));
                }
                if (state is AuthenticationLoading) {
                  return prefix0.LoadingIndicator();
                }
                return SplashPage();
              },
            ),
            routes: {
              prefix1.HomePage.routeName: (context) => prefix1.HomePage(),
              // SpeakerPage.routeName: (context) => SpeakerPage(),
              EventsPage.routeName: (context) => EventsPage(),
              ComingSoonPage.routeName: (context) => ComingSoonPage(),
              RankPage.routeName: (context) => RankPage(),
              NewsPageScreen.routeName: (context) => NewsPageScreen(),

              AttendancePageScreen.routeName: (context) =>
                  AttendancePageScreen(),
              ProjectsPageScreen.routeName: (context) => ProjectsPageScreen(),

              SignupPage.routeName: (context) => SignupPage(),
            },
          );
        }));
  }
}
