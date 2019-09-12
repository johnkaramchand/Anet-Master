import 'package:anet/agenda/event_list.dart';
import 'package:anet/home/session.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:anet/agenda/session_list.dart';
import 'package:anet/home/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:anet/home/events.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:anet/agenda/session_detail.dart';
import 'package:anet/home/session.dart';
import 'package:anet/utils/tools.dart';
import 'dart:math';


class CloudScreen extends StatelessWidget {
  final HomeBloc homeBloc;
   CloudScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var events = state.eventsData.events;
    var eventSessions = events.where((s) => s.event_type == 'general').toList();
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
       // header: defaultHeader,
        onRefresh: () async {
          print("Pulled down");
             homeBloc.dispatch(LoadEventsEvent());
             
             var events = state.eventsData.events;
             eventSessions = events.where((s) => s.event_type == 'general').toList();
          _refreshController.refreshCompleted();
        },
        child:buildlist(eventSessions,context)
        //EventList( allEvents: eventSessions)
        
        
       
      );

    /*var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );*/
  }

  Widget buildlist(var allEvents,context){
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allEvents.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: () {/*
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SessionDetail(
                    session: allSessions[i],
                  ),
                ),
              );*/
            },
            // dense: true,
            isThreeLine: true,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${allEvents[i].organizer}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                     text: "${allEvents[i].organizer}\n",
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            
            leading: Hero(
              tag: "${allEvents[i].event_id}\n",
              child: CircleAvatar(
                radius: 30,
                backgroundImage:
                
                    CachedNetworkImageProvider('https://avatars1.githubusercontent.com/u/12619420?s=400&u=eac38b075e4e4463edfb0f0a8972825cf7803d4c&v=4'),
              ),
            ),
            title: RichText(
              text: TextSpan(
                 text: "${allEvents[i].organizer}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                       text: "${allEvents[i].organizer}\n",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: []),
                ],
              ),
            ),
            subtitle: Text(
              "${allEvents[i].organizer}\n",
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
class RefreshBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
          background: Image.network(
        "https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c21b1ac3066ae4d354a3b2e0064c8be&auto=format&fit=crop&w=500&q=60",
        fit: BoxFit.cover,
      )),
    );
  }
}
