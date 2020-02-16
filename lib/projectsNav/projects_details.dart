import 'dart:math';
import 'package:anet/config/config_bloc.dart';
import 'package:anet/models/news_model.dart';
import 'package:anet/models/project_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetail extends StatelessWidget {
  static const String routeName = "/projectdetails";
  final Project project;

  ProjectDetail({Key key, @required this.project}) : super(key: key);
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
               imageUrl: project.p_image,
              )
              ),
              
                /* Center(
                child: CachedNetworkImage(
               // imageUrl: "${news.n_image}",
               imageUrl: project.p_image,
              )
              ),
              */

              SizedBox(
                height: 20,
              ),
              Text(
                "${project.p_title}",
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
                        /* Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.date_range,
                              // color: Colors.red,
                              FontAwesomeIcons.calendar,

                              color: ConfigBloc().darkModeOn
                                  ? Colors.red
                                  : Colors.redAccent,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              project.p_datetime,
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
                        ), */
                        /* Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.location_on

                              FontAwesomeIcons.building,
                              color: ConfigBloc().darkModeOn
                                  ? Colors.red
                                  : Colors.redAccent,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              project.p_title,
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
                        ), */
                        /* Column(
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              //Icons.access_time
                              FontAwesomeIcons.clock,
                              color: ConfigBloc().darkModeOn
                                  ? Colors.red
                                  : Colors.redAccent,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              project.p_datetime.toString(),
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
                        ), */
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        project.p_desc,
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
              /*   SizedBox(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    print("clicked");
                    _register(event.e_registration_link);
                  },
                  shape: StadiumBorder(),
                  child: Text(
                    "Photos",
                    style: TextStyle(
                        //color: Colors.black,
                        //  fontFamily: 'Raleway',
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.redAccent,
                ),
              ), */ 
              project.p_github_link.toString().length > 5 ||
                      project.p_medium_link.toString().length > 5
                  ? Text("For more info smash these icons.")
                  : SizedBox(),
              socialActions(context),
            ],
          ),
        ),
      ),
      title: project.p_title,
    );
  }

  Widget socialActions(context) => SizedBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            project.p_image.toString().length > 5
                ? IconButton(
                    icon: Icon(
                      FontAwesomeIcons.github,
                      size: 40,
                    ),
                    onPressed: () async {
                      if (project.p_github_link.toString().length > 5) {
                        await _launchURL("${project.p_github_link}");
                      } else {
                        print("NO DATA");
                      }
                    },
                  )
                : SizedBox(
                    width: 0,
                  ),
            SizedBox(
              width: 20,
            ),
            project.p_medium_link.toString().length > 5
                ? IconButton(
                    icon: Icon(
                      FontAwesomeIcons.medium,
                      size: 40,
                    ),
                    onPressed: () async {
                      if (project.p_medium_link.toString().length > 5) {
                        await _launchURL("${project.p_medium_link}");
                      } else {
                        print("NO DATA");
                      }
                    },
                  )
                : SizedBox(
                    width: 0,
                  ),
            SizedBox(
              width: 20,
            ),
            /*  IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 40,
              ),
              onPressed: () async {
                await _launchURL("${event.e_github_link}");
              },
            ), */ /* 
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
            ),*/
          ],
        ),
      );
        _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

