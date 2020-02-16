import 'package:anet/authentication_presentation/Registered.dart';
import 'package:anet/config/config_bloc.dart';
import 'package:anet/config/index.dart';
import 'package:anet/home/index.dart';
import 'package:anet/login_bloc/login.dart' as prefix0;
import 'package:anet/login_bloc/tempsignup.dart';
import 'package:anet/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/authentication_bloc/user_repository.dart';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:anet/authentication_presentation/splash_screen.dart';
import 'package:anet/login_bloc/login.dart';
import 'package:anet/registerPageStateless/registerPageStateless.dart';

import 'package:flutter/services.dart';
import 'utils/devfest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anet/login_bloc/signup_page.dart';
import 'package:anet/attendanceNav/attendancepagescreen.dart';
import 'package:anet/comingsoon.dart';
import 'package:anet/newsNav/newsPageScreen.dart';
import 'package:anet/projectsNav/projectsPage.dart';
import 'package:anet/rank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/eventsnav/eventsPage.dart';
import 'package:flutter/services.dart';
import 'utils/devfest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:anet/home/home_bloc.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
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
  // Injector.configure(Flavor.MOCK, DataMode.JSON);

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
          BlocProvider<HomeBloc>(builder: (context) {
            return HomeBloc();
          }),
        ],
        child: BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              //* Custom Google Font
              fontFamily: Devfest.josefin_sans_family,
              primarySwatch: Colors.red,
              primaryColor: configBloc.darkModeOn ? Tools.multiColors[5] : Colors.white,
              disabledColor: Colors.grey,
              cardColor: configBloc.darkModeOn ?Tools.multiColors[5]: Colors.white,
              canvasColor:
                  configBloc.darkModeOn ? Tools.multiColors[5] : Colors.grey[40],
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
            home: MultiBlocListener(
              listeners: [
                BlocListener<HomeBloc, HomeState>(
                  listener: (context, state) {},
                ),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {},
                ),
              ],
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  print(state);
                  if (state is AuthenticationAuthenticated) {
                    print("\n\n\n\n\n YAY!!!!!! LOADING HOME");
                    return HomePage();
                  }
                  if (state is AuthenticationUnauthenticated) {
                    return LoginPage(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context));
                  }
                  if (state is AuthenticationUnauthenticatedRegistered) {
                    return RegisteredPage();
                  }
                  if (state is AuthenticationUnauthenticatedRegister) {
                    return SignupPage(
                        userRepository:
                            RepositoryProvider.of<UserRepository>(context));
                  }
                  if (state is AuthenticationLoading) {
                    return prefix0.LoadingIndicator();
                  }
                  return SplashPage();
                },
              ),
            ),
            routes: {
              HomePage.routeName: (context) => HomePage(),
              // SpeakerPage.routeName: (context) => SpeakerPage(),
              EventsPage.routeName: (context) => EventsPage(),
              ComingSoonPage.routeName: (context) => ComingSoonPage(),
              RankPage.routeName: (context) => RankPage(),
              NewsPageScreen.routeName: (context) => NewsPageScreen(),

              AttendancePageScreen.routeName: (context) =>
                  AttendancePageScreen(),
              ProjectsPage.routeName: (context) => ProjectsPage(),

              TempSignupPage.routeName: (context) => TempSignupPage(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  ),
                  RegisterStateless.routeName: (context) =>RegisterStateless(),

              /*   SignupPage.routeName: (context) => SignupPage(
                    userRepository:
                        RepositoryProvider.of<UserRepository>(context),
                  ), */
            },
          );
        }));
  }
}
