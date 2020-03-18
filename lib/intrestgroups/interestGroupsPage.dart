import 'dart:math';

import 'package:anet/projectsNav/projectsPageScreen.dart';
import 'package:anet/intrestgroups/interestGroupsScreen.dart';
import 'package:flutter/material.dart';
import 'package:anet/projectsNav/projectIdeasScreen.dart';

import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InterestGroupsPage extends StatelessWidget {
  static const String routeName = "/interestgroups";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DefaultTabController(
      length: 2,
      child: DevScaffold(
        title: "Interest Groups",
        
        body:InterestGroupsScreen(
              homeBloc: _homeBloc,
            ),
      ),
    );
  }
}
