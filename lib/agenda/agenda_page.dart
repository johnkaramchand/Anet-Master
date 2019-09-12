import 'dart:math';

import 'package:flutter/material.dart';
import 'package:anet/agenda/cloud_screen.dart';
import 'package:anet/agenda/mobile_screen.dart';
import 'package:anet/agenda/web_screen.dart';
import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DefaultTabController(
      length: 3,
      child: DevScaffold(
        title: "Events",
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[Random().nextInt(4)],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text("General"),
              icon: Icon(
                FontAwesomeIcons.dotCircle,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Sessions"),
              icon: Icon(
                FontAwesomeIcons.briefcase,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Competitions"),
              icon: Icon(
                FontAwesomeIcons.moneyCheckAlt,
                size: 12,
              ),
            )
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            CloudScreen(
              homeBloc: _homeBloc,
            ),
            MobileScreen(
              homeBloc: _homeBloc,
            ),
            WebScreen(
              homeBloc: _homeBloc,
            ),
          ],
        ),
      ),
    );
  }
}
