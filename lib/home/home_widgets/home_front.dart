import 'package:anet/attendanceNav/attendancepagescreen.dart';
import 'package:anet/comingsoon.dart';
import 'package:anet/home/index.dart';
import 'package:anet/intrestgroups/interestGroupsPage.dart';
import 'package:anet/newsNav/newsPageScreen.dart';
import 'package:anet/projectsNav/projectsPage.dart';
import 'package:anet/supersaiyanUI/supersaiyanlogin.dart';
import 'package:flutter/material.dart';
import 'package:anet/eventsnav/eventsPage.dart';
import 'package:anet/config/index.dart';
import 'package:anet/utils/devfest.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:anet/home/home_bloc.dart';

class HomeFront extends StatefulWidget {
  final HomeBloc _homeBloc;
  HomeFront(this._homeBloc);
  @override
  State<StatefulWidget> createState() {
    return HomeFrontState(_homeBloc);
  }
}

class HomeFrontState extends State<HomeFront> {
  var statsAttended;
  var totalsore;
  var username;
  final HomeBloc homeBloc;
  HomeFrontState(this.homeBloc);

  @override
  void initState() {
    super.initState();
    var state = homeBloc.currentState as InHomeState;
    statsAttended = state.stats.total_count;
    totalsore = state.stats.score_sum;
    username = state.username;
    print(username);
  }

  Widget newUIdata(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Container(
          child: Column(
            children: <Widget>[
              new Text(
                statsAttended.toString() ?? '-',
                style: TextStyle(
                  color: Color.fromRGBO(238, 255, 248, 1),
                  fontSize: 40,
                ),
              ),
              new Divider(
                height: 2,
              ),
              new Text(
                "Events Attended",
                style: Theme.of(context).textTheme.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        new VerticalDivider(
          width: 1,
          color: Colors.red,
        ),
        new Container(
          child: Column(
            children: <Widget>[
              new Text(
                totalsore.toString() ?? '-',
                style: TextStyle(
                    color: Color.fromRGBO(238, 255, 248, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              new Divider(
                height: 2,
              ),
              new Text(
                "Community Score",
                style: Theme.of(context).textTheme.body2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> devFestTexts(context) => [
        SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          // height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Container(
                child: Column(
                  children: <Widget>[
                    new Text(
                      statsAttended.toString() ?? '-',
                      style: TextStyle(
                        color: Tools.multiColors[Random().nextInt(4)],
                        fontSize: 40,
                      ),
                    ),
                    new Divider(
                      height: 2,
                    ),
                    new Text(
                      "Events Attended",
                      style: Theme.of(context).textTheme.body2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              new VerticalDivider(
                width: 1,
                color: Colors.red,
              ),
              new Container(
                child: Column(
                  children: <Widget>[
                    new Text(
                      totalsore.toString() ?? '-',
                      style: TextStyle(
                          color: Tools.multiColors[Random().nextInt(4)],
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    new Divider(
                      height: 2,
                    ),
                    new Text(
                      "Community Score",
                      style: Theme.of(context).textTheme.body2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: ConfigBloc().darkModeOn
                ? Tools.hexToColor("#1f2124")
                : Colors.white,
            borderRadius: BorderRadius.circular(
              10.0,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ];

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget actions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 10.0,
        children: <Widget>[
          RaisedButton(
            child: Text("Agenda"),
            shape: StadiumBorder(),
            color: Colors.red,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          RaisedButton(
            child: Text("EventsSessions"),
            shape: StadiumBorder(),
            color: Colors.green,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          RaisedButton(
            child: Text("Sponsors"),
            shape: StadiumBorder(),
            color: Colors.orange,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          RaisedButton(
            child: Text("Team"),
            shape: StadiumBorder(),
            color: Colors.purple,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          RaisedButton(
            child: Text("FAQ"),
            shape: StadiumBorder(),
            color: Colors.brown,
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          RaisedButton(
            child: Text("Locate Us"),
            shape: StadiumBorder(),
            color: Tools.multiColors[4],
            colorBrightness: Brightness.dark,
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
        ],
      );

  Widget newActions(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: <Widget>[
          ActionCard(
            icon: FontAwesomeIcons.calendar,
            color: Colors.blueAccent,
            title: "Events",
            onPressed: () => Navigator.pushNamed(context, EventsPage.routeName),
          ),
          ActionCard(
              icon: FontAwesomeIcons.solidHeart,
              color: Colors.redAccent,
              title: "Interest\nGroups",
              onPressed: () async {
                Navigator.pushNamed(context, InterestGroupsPage.routeName);
                /* await _launchURL(
                    "http://test.ciadev.ninja/interest-groups/"); */
              }
              //Navigator.pushNamed(context, ProjectsPageScreen.routeName),
              ),
          ActionCard(
            icon: FontAwesomeIcons.database,
            color: Tools.multiColors[Random().nextInt(4)],
            title: "Projects",
            onPressed: () =>
                Navigator.pushNamed(context, ProjectsPage.routeName),
          ),
          ActionCard(
              icon: FontAwesomeIcons.microchip,
              color: Colors.amber,
              title: "Atria Iot Lab",
              onPressed: () async {
                await _launchURL("http://iot.atria.edu");
              }),
          ActionCard(
            icon: FontAwesomeIcons.newspaper,
            color: Colors.green,
            title: "News",
            onPressed: () =>
                Navigator.pushNamed(context, NewsPageScreen.routeName),
          ),
          ActionCard(
            icon: FontAwesomeIcons.trophy,
            color: Colors.amber,
            title: "Rank",
            onPressed: () =>
                Navigator.pushNamed(context, ComingSoonPage.routeName),
          ),
          ActionCard(
            icon: FontAwesomeIcons.checkSquare,
            color: Colors.purple,
            title: "Rewards",
            onPressed: () =>
                Navigator.pushNamed(context, AttendancePageScreen.routeName),
          ),
          ActionCard(
            icon: FontAwesomeIcons.book,
            color: Tools.multiColors[Random().nextInt(4)],
            title: "Attendance",
            onPressed: () =>
                Navigator.pushNamed(context, SuperSaiyanLoginPage.routeName),
          ),

          /*
          ActionCard(
            icon: FontAwesomeIcons.solidNewspaper,
            color: Colors.brown,
            title: "Notes",
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          ActionCard(
            icon: Icons.map,
            color: Colors.blue,
            title: "Where is?",
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          )*/
        ],
      );

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookF),
              onPressed: () async {
                await _launchURL(
                    "https://www.facebook.com/CIA-1069919769829271/");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.instagram),
              onPressed: () async {
                await _launchURL(
                    "https://www.instagram.com/cia_together/?hl=en");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL("https://twitter.com/cia_together");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.linkedinIn),
              onPressed: () async {
                _launchURL(
                    "https://www.linkedin.com/company/communities-in-atria");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.youtube),
              onPressed: () async {
                await _launchURL(
                    "https://www.youtube.com/channel/UCVOsWDAhARY9WnJzkFj4Jrg ");
              },
            ),
            /*
            IconButton(
              icon: Icon(FontAwesomeIcons.meetup),
              onPressed: () async {
                await _launchURL("https://meetup.com/");
              },
            ),*/
            IconButton(
              icon: Icon(FontAwesomeIcons.envelope),
              onPressed: () async {
                var emailUrl =
                    '''mailto:communities.atria@gmail.com?subject=We love CIA-CommunitiesInAtria&body=Communities are great !!!''';
                var out = Uri.encodeFull(emailUrl);
                await _launchURL(out);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              child: Icon(
                FontAwesomeIcons.userAstronaut,
                size: 80,
              ),
/*
      decoration: BoxDecoration(
        color: ConfigBloc().darkModeOn
            ? Tools.hexToColor("#1f2124")
            : Colors.white,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),*/
            ),
            Text(
              "Hey, $username",
              style: Theme.of(context).textTheme.headline.merge(TextStyle(
                    fontSize: 32,
                  )),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),

            /*
            ImageCard(
              img: ConfigBloc().darkModeOn
                  ? Devfest.banner_dark
                  : Devfest.banner_light,
            ),*/
            newUIdata(context),
            //...devFestTexts(context),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            newUInav(context),
            //newActions(context),
            SizedBox(
              height: 20,
            ),
            socialActions(context),
            SizedBox(
              height: 20,
            ),
            Text(
              Devfest.app_version,
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

Widget newUInav(context) {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)),
            minWidth: MediaQuery.of(context).size.width / 2.5,
            height: 50,
            child: FlatButton(
              onPressed: () {
                 Navigator.pushNamed(context, EventsPage.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Events',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              color: Tools.multiColors[4],
              splashColor: Tools.multiColors[4],
              colorBrightness: Brightness.dark,
            ),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: FlatButton(
              onPressed: () {
                 Navigator.pushNamed(context, ProjectsPage.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    //Icons.check_box_outline_blank,
                    FontAwesomeIcons.database,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Projects',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              color: Tools.multiColors[4],
              splashColor: Tools.multiColors[4],
              colorBrightness: Brightness.dark,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ButtonTheme(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.red)),
        minWidth: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        child: FlatButton(
          onPressed: () {
             Navigator.pushNamed(context, InterestGroupsPage.routeName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.connectdevelop,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Interest Groups',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              )
            ],
          ),
          color: Tools.multiColors[4],
          splashColor: Tools.multiColors[4],
          colorBrightness: Brightness.dark,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)),
            minWidth: MediaQuery.of(context).size.width / 2.5,
            height: 50,
            child: FlatButton(
              onPressed: () {
                 Navigator.pushNamed(context, NewsPageScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.newspaper,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'News',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              color: Tools.multiColors[4],
              splashColor: Tools.multiColors[4],
              colorBrightness: Brightness.dark,
            ),
          ),
          ButtonTheme(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.red)),
            minWidth: MediaQuery.of(context).size.width / 2,
            height: 50,
            child: FlatButton(
              onPressed: () {
                 Navigator.pushNamed(context, AttendancePageScreen.routeName);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.checkSquare,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Rewards',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  )
                ],
              ),
              color: Tools.multiColors[4],
              splashColor: Tools.multiColors[4],
              colorBrightness: Brightness.dark,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20,
      ),
      ButtonTheme(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.red)),
        minWidth: MediaQuery.of(context).size.width / 2.5,
        height: 50,
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, SuperSaiyanLoginPage.routeName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.connectdevelop,
                color: Colors.black,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Attendance',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              )
            ],
          ),
          color: Tools.multiColors[4],
          splashColor: Tools.multiColors[4],
          colorBrightness: Brightness.dark,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        //alignment: Alignment(1.0, 0.0),
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 15.0, left: 20.0),
        child: InkWell(
          onTap: () async{
            var url = "http://cia.atria.edu";
          try{
            launch(url);
            
          }catch(error){
            print(error);
          }
           
          },
          child: Text(
            'cia.atria.edu',
            style: TextStyle(
                color: Tools.multiColors[4],
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 18),
          ),
        ),
      ),
    ],
  );
}

class ActionCard extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final Color color;

  const ActionCard({Key key, this.onPressed, this.icon, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: ConfigBloc().darkModeOn
              ? Tools.hexToColor("#1f2124")
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: !ConfigBloc().darkModeOn
              ? [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
