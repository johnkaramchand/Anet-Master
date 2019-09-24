import 'package:anet/eventsnav/event_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/home/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:anet/utils/tools.dart';
import 'dart:math';


class UpcomingEventsScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  UpcomingEventsScreen( {
      Key key, this.homeBloc
    }

  ) : super(key: key);
  final RefreshController _refreshController=RefreshController();


  @override Widget build(BuildContext context) {
    var state=homeBloc.currentState as InHomeState;
    var events=state.eventsData.events;

    for (var i in events) {
      print(i.e_id);
    }

    var eventSessions=events.where((s)=> s.e_state==true).toList();
    print("DATA : ${events[0].e_id}");
    

    return SmartRefresher(controller: _refreshController,
      enablePullDown: true,
      // header: defaultHeader,
      onRefresh: () async {
        print("Pulled down");
        homeBloc.dispatch(LoadEventsEvent());

        var events=state.eventsData.events;
        eventSessions=events.where((s)=> s.e_state==false).toList();
        _refreshController.refreshCompleted();
      }

      ,
      child:buildlist(eventSessions, context) //EventList( allEvents: eventSessions)



    );


  }

  Widget buildlist(var allEvents, context) {

    return ListView.builder(shrinkWrap: false,
      itemCount: allEvents.length,
      itemBuilder: (c, i) {

        // return Text("sdd");
        return Card(elevation: 0.0,
          child: ListTile(onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> EventsDetail(event: allEvents[i],
                  ),
                ),
              );
            }

            ,
            // dense: true,
            isThreeLine: true,
            trailing: RichText(textAlign: TextAlign.center,
              text: TextSpan(text: "${allEvents[i].e_start_time.toString().substring(0,5)} to ",
                style: Theme.of(context) .textTheme .title .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                children: [ TextSpan(text: "${allEvents[i].e_end_time.toString().substring(0,5)}\n",
                  style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 12, fontWeight: FontWeight.w500,
                  ),
                  
                ),
                ],
              ),
            ),

            leading: Hero(tag: "${allEvents[i].e_title}\n",
              child: CircleAvatar(radius: 30,
                    child: Image.asset('assets/images/ca.png'),
                //backgroundImage:  CachedNetworkImageProvider('https://www.flaticon.com/authors/alfredo-hernandez'),
              ),
            ),
            title: RichText(text: TextSpan(text: "${allEvents[i].e_title}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [ TextSpan(text: "${allEvents[i].e_organizer}\n",
                  style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: 14,
                    color: Tools.multiColors[Random().nextInt(4)],
                  ),
                  children: []),
                ],
              ),
            ),
            subtitle: Text("${allEvents[i].e_description}\n",
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10.0,
              ),
            ),
          ),
        );
      }

      ,
    );

  }
}

class RefreshBackground extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return SliverAppBar(expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(background: Image.network("https://images.unsplash.com/photo-1541701494587-cb58502866ab?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=0c21b1ac3066ae4d354a3b2e0064c8be&auto=format&fit=crop&w=500&q=60",
          fit: BoxFit.cover,
        )),
    );
  }
}