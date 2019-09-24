import 'dart:math';

import 'package:anet/agenda/event_details.dart';
import 'package:anet/models/events.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/agenda/session_detail.dart';
import 'package:anet/home/session.dart';
import 'package:anet/utils/tools.dart';

class EventList extends StatelessWidget {
  final List<Event> allEvents;

  const EventList({Key key, @required this.allEvents}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allEvents.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventsDetail(
                    event: allEvents[i],
                  ),
                ),
              );
            },
            // dense: true,
            isThreeLine: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${allEvents[i].e_organizer}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                     text: "${allEvents[i].e_organizer}\n",
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            
            leading: Hero(
              tag: "${allEvents[i].e_id}\n",
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                
                    CachedNetworkImageProvider('https://avatars1.githubusercontent.com/u/12619420?s=400&u=eac38b075e4e4463edfb0f0a8972825cf7803d4c&v=4'),
              ),
            ),
            title: RichText(
              text: TextSpan(
                 text: "${allEvents[i].e_organizer}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                       text: "${allEvents[i].e_organizer}\n",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: []),
                ],
              ),
            ),
            subtitle: Text(
              "${allEvents[i].e_organizer}\n",
              style: Theme.of(context).textTheme.caption.copyWith(
                    fontSize: 10.0,
                  ),
            ),
          ),
        );
      },
    );
  }
}
