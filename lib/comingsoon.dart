import 'dart:math';

import 'package:anet/news_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/agenda/mobile_screen.dart';
import 'package:anet/agenda/web_screen.dart';
import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';


class ComingSoonPage extends StatelessWidget {
  static const String routeName = "/comingsoon";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return  DevScaffold(
        title: "",
       
        body: ComingSoonScreen(
              homeBloc: _homeBloc,
            ),
      );
  }
}

class ComingSoonScreen extends StatelessWidget {
  final HomeBloc homeBloc;
   ComingSoonScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    
    return Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("In Progress"),
            Text("Yes buddy! we're still working on it."),

          ],
        ),
    );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }

  
}