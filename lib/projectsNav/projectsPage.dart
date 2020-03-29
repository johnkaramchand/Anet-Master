import 'dart:math';

import 'package:anet/projectsNav/projectsPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:anet/projectsNav/projectIdeasScreen.dart';

import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsPage extends StatelessWidget {
  static const String routeName = "/projects";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DefaultTabController(
      length: 2,
      child: DevScaffold(
        title: "Projects",
        tabBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Tools.multiColors[4],
          labelStyle: TextStyle(
            fontSize: 12,
          ),
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              child: Text("Ongoing"),
              icon: Icon(
                FontAwesomeIcons.asterisk,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Ideas"),
              icon: Icon(
                FontAwesomeIcons.dotCircle,
                size: 12,
              ),
            ),/*
            Tab(
              child: Text("Competitions"),
              icon: Icon(
                FontAwesomeIcons.moneyCheckAlt,
                size: 12,
              ),
            )*/
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ProjectsPageScreen(
              homeBloc: _homeBloc,
            ),
            ProjectIdeasScreen(
              homeBloc: _homeBloc,
            ),/*
            WebScreen(
              homeBloc: _homeBloc,
            ),*/
          ],
        ),
      ),
    );
  }
}
