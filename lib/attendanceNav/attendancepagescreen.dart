import 'dart:math';

import 'package:anet/login_bloc/loading_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anet/network/rest_client.dart';

import 'package:anet/newsNav/news_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/eventsnav/pastevents_screen.dart';

import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:anet/authentication_bloc/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePageScreen extends StatefulWidget {
  static const String routeName = "/attendance";

  var _homeBloc = HomeBloc();
  @override
  State<StatefulWidget> createState() {
    return AttendanceScreen(homeBloc: _homeBloc);
  }

/*   @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return DevScaffold(
      title: "",
      body: AttendanceScreen(
        homeBloc: _homeBloc,
      ),
    );
  } */
}

class AttendanceScreen extends State<AttendancePageScreen> {
  final HomeBloc homeBloc;
  // UserRepository userRepository = UserRepository();
  //AttendanceScreen({Key key, this.homeBloc}) : super(key: key);
  AttendanceScreen({Key key, this.homeBloc});
  final RefreshController _refreshController = RefreshController();
  TextEditingController eventCode = TextEditingController();

  String token;
  bool current;
  final snackBar = SnackBar(content: Text('FAILED'));

  @override
  void initState() {
    super.initState();
    current = true;
    getToken();
  }

  attendApi(String token, String eventcode) async {
    setState(() {
      current = false;
    });
    var response;
    Map<String, String> headers = {"Content-type": "application/json"};

    String jsonRequest = '{"token": "$token", "e_code":"$eventcode"}';
    try {
      print('api test');
      response = await http.post('http://139.59.61.35:8000/api/v2/attend/',
          body: jsonRequest, headers: headers);
      print(response.body);
      var res = json.decode(response.body);
      if (res['response'] == 'true') {
        setState(() {
          current = true;
        });
      } else {
        setState(() {
          current = true;
          Scaffold.of(context).showSnackBar(snackBar);
        });

        print("mdfinvfn");
      }
    } catch (error) {}

    //var jsonresponse = json.decode(response.body);

    //  print("response : $jsonresponse");
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: 'Attend',
      body: current ? _attendancescreen() : _loadScreen(),
    );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }

  Widget _loadScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _attendancescreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "CLAIM POINTS ",
              style:
                  Theme.of(context).textTheme.headline.copyWith(fontSize: 30),
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
              child: TextField(
                style: TextStyle(),
                controller: eventCode,
              ),
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

                  // print(getToken());
                  print(token);
                  attendApi(token.toString(), eventCode.text);
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
      ),
    );
  }

  Future<Null> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = await prefs.getString('communitiesinatria-token');
    token = stringValue;
    //Return bool
  }
}
