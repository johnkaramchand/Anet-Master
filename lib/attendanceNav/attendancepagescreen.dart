import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:anet/home/index.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
      response = await http.post('https://cia.atria.edu/api/v2/attend/',
          body: jsonRequest, headers: headers);
      print(response.body);
      var res = json.decode(response.body);
      print(res);
      if (res['response'] == true) {
        print("True");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            error: 'Attendence Confirmed',
            onTap: () {
              setState(() {
                current = true;
              });
              //_homeBloc.dispatch(LoadHomeEvent());
            },
          ),
        );
      } else {
        print("Failed");
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            error: 'ERROR',
            onTap: () {
              setState(() {
                current = true;
              });
              //_homeBloc.dispatch(LoadHomeEvent());
            },
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          error: 'Error',
          onTap: () {
            setState(() {
              current = true;
            });
            //_homeBloc.dispatch(LoadHomeEvent());
          },
        ),
      );
    }

    //var jsonresponse = json.decode(response.body);

    //  print("response : $jsonresponse");
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: 'Attendance',
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
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Proof that you were here!",
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            /*  Icon(
              FontAwesomeIcons.save,
              size: 50,
            ),
            SizedBox(
              height: 30,
            ), */
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                style: TextStyle(),
                decoration:
                    InputDecoration(hintText: "ENTER YOUR EVENT CODE HERE"),
                controller: eventCode,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  print("clicked");

                  // print(getToken());
                  print(token);
                  attendApi(token.toString(), eventCode.text);
                },
                shape: StadiumBorder(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*    Icon(Icons.book),
                    SizedBox(
                      width: 10,
                    ), */
                    Text(
                      "CLAIM",
                      style: TextStyle(
                          //color: Colors.black,
                          //  fontFamily: 'Raleway',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.open_in_new),
                  ],
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

class Dialog extends StatelessWidget {
  final Widget child;
  final error;
  final Function onTap;

  Dialog({Key key, this.child, this.error = 'okay', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(error),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  shape: StadiumBorder(),
                  colorBrightness: Brightness.dark,
                  child: Text('okay'),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                    if (onTap != null) {
                      onTap();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
