import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:anet/models/events.dart';
import 'package:anet/config/config_bloc.dart';

class EventsDetail extends StatelessWidget {
  static const String routeName = "/events_details";
  final Event event;


  EventsDetail({Key key, @required this.event}) : super(key: key);

/*
  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].githubUrl);
              },
            ),
          ],
        ),
      );
*/
  @override
  Widget build(BuildContext context) {
    print(event.e_image);
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*  Center(
                child: Hero(
                  tag: event.e_id,
                  child: Image.asset('assets/images/ca.png'),
                ),
              ), */
              /*  SizedBox(
                height: 10,
              ),
              Text(
                "${event.e_title}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 14,
                      color: Tools.multiColors[Random().nextInt(4)],
                    ),
              ), */
              
                Center(
                child: CachedNetworkImage(
               // imageUrl: "${news.n_image}",
               imageUrl: event.e_image,
              )
              ),
             
              SizedBox(
                height: 20,
              ),
              Text(
                "${event.e_title}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.overline.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              /* SizedBox(
                height: 15,
              ),
              Text(
                //"${event.e_organizer}",
                "${event.e_organizer}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14,
                      //color: Tools.multiColors[Random().nextInt(4)],
                    ),
              ), */
              SizedBox(
                height: 25,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.date_range,
                              // color: Colors.red,
                              FontAwesomeIcons.calendar,

                              color: ConfigBloc().darkModeOn
                                  ? Tools.multiColors[4]
                                  : Tools.multiColors[4],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              event.e_date,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.location_on

                              FontAwesomeIcons.building,
                              color: ConfigBloc().darkModeOn
                                  ? Tools.multiColors[4]
                                  : Tools.multiColors[4],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              event.e_venue,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.access_time
                              FontAwesomeIcons.clock,
                              color: ConfigBloc().darkModeOn
                                  ? Tools.multiColors[4]
                                  : Tools.multiColors[4],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              event.e_start_time.toString(),
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        event.e_description,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ]),
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
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    print("clicked");
                    _register(event.e_registration_link);
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        //color: Colors.black,
                        //  fontFamily: 'Raleway',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Tools.multiColors[4],
                ),
              ),

              // socialActions(context),
            ],
          ),
        ),
      ),
      title: event.e_title,
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
}
