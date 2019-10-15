import 'dart:io';
import 'dart:math';

import 'package:anet/authentication_bloc/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anet/dialogs/error_dialog.dart';
import 'package:anet/home/home_widgets/home_front.dart';
import 'package:anet/home/index.dart';
import 'package:anet/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required HomeBloc homeBloc,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState(_homeBloc);
  }
}

class HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc;
  HomeScreenState(this._homeBloc);
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    this._homeBloc.dispatch(LoadHomeEvent());
    firebaseCloudMessaging_Listeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(
                message['notification']['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget._homeBloc,
      listener: (context, state) {
        if (state is ErrorHomeState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => ErrorDialog(
              error: state.errorMessage,
              onTap: () {
                _homeBloc.dispatch(LoadHomeEvent());
              },
            ),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          bloc: widget._homeBloc,
          builder: (
            BuildContext context,
            HomeState currentState,
          ) {
            if (currentState is InHomeState) {
              return HomeFront(_homeBloc);
            } else if (currentState is UnHomeState) {
              return Center(
                child: SpinKitChasingDots(
                  color: Tools.multiColors[Random().nextInt(3)],
                ),
              );
            } else if (currentState is ErrorHomeState) {
              return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      currentState.errorMessage ?? 'Error',
                      textAlign: TextAlign.center,
                    ),
                  ));
            } else {
              return HomeFront(_homeBloc);
            }
            return HomeFront(_homeBloc);
          }),
    );
  }
}
