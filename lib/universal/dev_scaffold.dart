import 'package:anet/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:anet/config/config_bloc.dart';
import 'package:anet/config/config_event.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anet/authentication_bloc/authentication.dart';


class DevScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget tabBar;

  const DevScaffold(
      {Key key, @required this.body, @required this.title, this.tabBar})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
        final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: ConfigBloc().darkModeOn ? Colors.grey[800] : Colors.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            bottom: tabBar != null ? tabBar : null,
            actions: <Widget>[
              IconButton(
                icon: Icon(FontAwesomeIcons.signOutAlt),
                onPressed: (){
                  authenticationBloc.dispatch(LoggedOut()) ;

                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20,
                ),
                onPressed: () {
                    authenticationBloc.dispatch(LoggedOut());
                },
              ),
              IconButton(
                icon: Icon(
                  ConfigBloc().darkModeOn
                      ? FontAwesomeIcons.lightbulb
                      : FontAwesomeIcons.solidLightbulb,
                  size: 18,
                ),
                onPressed: () {
                  ConfigBloc()
                      .dispatch(DarkModeEvent(!ConfigBloc().darkModeOn));
                },
              ),
              IconButton(
                onPressed: () => Share.share(
                    "Download the new DevFest App and share with your tech friends.\nPlayStore -  http://bit.ly/2GDr18N"),
                icon: Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ],
          ),
          body: body,
        ),
      ),
    );
  }
}
