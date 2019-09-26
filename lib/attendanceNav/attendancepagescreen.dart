import 'dart:math';

import 'package:anet/newsNav/news_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/eventsnav/pastevents_screen.dart';

import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendancePageScreen extends StatelessWidget {
  static const String routeName = "/comingsoon";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DevScaffold(
      title: "",
      body: AttendanceScreen(
        homeBloc: _homeBloc,
      ),
    );
  }
}

class AttendanceScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  AttendanceScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;

    return Padding(
      padding: EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "CLAIM \nPOINTS ",
            style: Theme.of(context).textTheme.headline.copyWith(fontSize: 30),
            textAlign: TextAlign.justify,
          ),
          Icon(
            FontAwesomeIcons.checkSquare,
          ),
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(style: TextStyle()),
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                print("clicked");
                //register(event.e_registration_link);
              },
              shape: StadiumBorder(),
              child: Text(
                "Claim Attendance",
                style: TextStyle(
                    //color: Colors.black,
                    //  fontFamily: 'Raleway',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.green,
            ),
          ),
          SizedBox(
            height: 60,
          ),
        ],
      )),
    );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }
}
