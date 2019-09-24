import 'dart:math';

import 'package:anet/models/news_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/universal/dev_scaffold.dart';
import 'package:anet/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:anet/models/events.dart';

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
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: event.e_id,
                  child:Image.asset('assets/images/ca.png'),
                ),
              ),
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
              SizedBox(
                height: 20,
              ),
              Text(
                "${event.e_title}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${event.e_organizer}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 14,
                      color: Tools.multiColors[Random().nextInt(4)],
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[ 
                      
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.calendar,color: Tools.multiColors[Random().nextInt(4)],),
                          SizedBox(
                            height: 10,
                          ),
                          Text(event.e_date)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.building,color: Tools.multiColors[Random().nextInt(4)],),
                          SizedBox(
                            height: 10,
                          ),
                          Text(event.e_venue)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.clock,color: Tools.multiColors[Random().nextInt(4)],),
                          SizedBox(
                            height: 10,
                          ),
                          Text(event.e_start_time.toString())
                        ],
                      ),
                ],
              )
              ,
              SizedBox(
                height: 15,
              ),
               Text(
                event.e_description,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 25,
              ),
          
          
              RaisedButton(
                onPressed: (){

                },
                color: Colors.green,
                
                shape: StadiumBorder(),
                child: Text("REGISTER"),
              )
             // socialActions(context),
            ],
          ),
        ),
      ),
      title: event.e_title,
    );
  }
}