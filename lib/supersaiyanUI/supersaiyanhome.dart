import 'dart:io';
import 'dart:math';
import 'package:anet/models/academiauser.dart';
import 'package:http_auth/http_auth.dart' as httpauth;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:anet/config/config_bloc.dart';

class SuperSaiyanHome extends StatefulWidget {
  static const String routeName = "/supersaiyanhome";

  final String dummy = "";
  

//  var _homeBloc = HomeBloc();
  @override
  State<StatefulWidget> createState() {
    return SuperSaiyanHomeScreen();
  }
}

class SuperSaiyanHomeScreen extends State<SuperSaiyanHome> {
  String token;
  bool current;
  

  // for user

  int userid;
  String usn;
  String username;
  String emailid;
   SaiyanAttendanceData saiyanAttendanceData;

  @override
  void initState() {
    super.initState();
    current = false;
    //getUserDetails(token);
    getToken();
    print("INIT");
  }

  attendApi(String token, int userid) async {
    /*   setState(() {
      current = false;
    }); */
    var response;
    print("token: $token userid : $userid");
    try {
      String basicAuth = 'bearer ' + token;

      print('api test');
      response = await http.get(
        'https://ait.academiaerp.com/rest/studentAttendanceDashboardStudentWise/findByCriteriaWithoutCCPJoin?studentId=$userid&attendanceType=COURSE_LEVEL&isCurrentPeriod=false',
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );
      var res1 = json.decode(response.body);

        /* setState(() {
          saiyanAttendanceData = SaiyanAttendanceData.fromJson(res1);
          current= true;
        

          
        }); */
        

      
      print("THIS IS THE USER : $res1");
      try{
         
      
saiyanAttendanceData = SaiyanAttendanceData.fromJson(res1);
setState(() {
  current=true;
});
      }
      catch(error){

        print("$error");
      }
       
       print(saiyanAttendanceData.toString());




    
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          error: 'Error',
          onTap: () {
            setState(() {
             // current = true;
            });
            //_homeBloc.dispatch(LoadHomeEvent());
          },
        ),
      );
    }

    //var jsonresponse = json.decode(response.body);

    //  print("response : $jsonresponse");
  }

  getUserDetails(String token) async {
    /*    setState(() {
      current = false;
    }); */
    var response;

    
    try {
      String basicAuth = 'bearer ' + token;
      
      Map<String, String> head = {
         HttpHeaders.authorizationHeader: basicAuth,
          
      };


      print('api test : $basicAuth');
      response = await http.get(
        'https://ait.academiaerp.com/rest/authentication/features',
        headers: head,
      );
       var res1 = json.decode(response.body);
  
       

      var res2 = res1['user'];
      userid = res2['id'];
      usn = res2['code'];
      emailid = res2['emailId'];
      username = res2['firstName'] + ' ' + res2['lastName'];
      print("THIS IS THE USER : $res2");
      
      attendApi(token, userid); 
    } catch (error) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          error: 'Error $error',
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

  


  

    
    //  print("event".e_image);
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      title: "Attendance",
      body: current ? _attendancescreen(  saiyanAttendanceData.saiyanattendance, context) : _loadScreen(),
    );
  }

  _register(String url) async {
    print("URL :  $url");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _loadScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _attendancescreen(var saiyanAttendanceData, context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: saiyanAttendanceData.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              /*   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsDetail(
                    event: allEvents[i],
                  ),
                ),
              ); */
            },
            // dense: true,
            isThreeLine: true,
            /*   trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "cr",//"${allEvents[i].e_organizer}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 28, fontWeight: FontWeight.bold),
              
              ),
            ), */

            leading: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${saiyanAttendanceData[i].attendancePercentage}"+"%", //"${allEvents[i].e_organizer}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: "${saiyanAttendanceData[i].courseName}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 22,color: Tools.multiColors[4]),
                
                children: [
                  TextSpan(
                      text: "\n",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 18,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: [
                        TextSpan(
                          text: "${saiyanAttendanceData[i].courseCode}\n",
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                          //color: Tools.multiColors[Random().nextInt(4)],
                          )
                        )
                      ]),
                ],
              ),
            ),
            subtitle: Text(
              "",
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 0.0,
                  ),
            ),
          ),
        );
      },
    );
  }

   Future<Null> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    //String stringValue = await prefs.getString('communitiesinatria-token');
    String stringValue =
        prefs.getString('communitiesinatria-academia-access-token');
    print("TOKEN RETRIVED :  $stringValue");
    token = stringValue;
    getUserDetails(token);
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
