import 'package:anet/eventsnav/event_details.dart';
import 'package:flutter/material.dart';
import 'package:anet/home/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:anet/utils/tools.dart';
import 'dart:math';

class UpcomingEventsScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  UpcomingEventsScreen({Key key, this.homeBloc}) : super(key: key);
  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return Center(
              child: SpinKitChasingDots(
                color: Tools.multiColors[Random().nextInt(3)],
              ),
            );
          }
          if (currentState is ErrorHomeState) {
            return Container(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    currentState.errorMessage ?? 'Error',
                    textAlign: TextAlign.center,
                  ),
                ));
          }

          var state = homeBloc.currentState as InHomeState;
          var events = state.eventsData.events;

          for (var i in events) {
            print(i.e_id);
          }

          var eventSessions = events.where((s) => s.e_state == true).toList();
          // Uncomment if you want to reverse the list
          //  eventSessions.sort((a, b) => b.e_date.compareTo(a.e_date));
          print("DATA : ${events[0].e_id}");

          return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              // header: defaultHeader,
              onRefresh: () async {
                print("Pulled down");
                homeBloc.dispatch(LoadHomeEvent());

                /*  var events = state.eventsData.events;
          eventSessions = events.where((s) => s.e_state == false).toList(); */
                _refreshController.refreshCompleted();
              },
              child: buildlist(
                  eventSessions, context) //EventList( allEvents: eventSessions)

              );
        });
  }

  Widget buildlist(var allEvents, context) {
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allEvents.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          /*  color: ConfigBloc().darkModeOn
                                ? Colors.black
                                : Colors.green,
         */
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(8),
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
              leading: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "${allEvents[i].e_date.toString().substring(8, 10)} ",
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color:Tools.multiColors[4]),
                      ), 
                      //Text("AUG"),
                      /* Text(
                        "${allEvents[i].e_date.toString().substring(5, 7)}",
                        style: TextStyle(color: Colors.grey[600]),
                      ), */
                    ],
                  ),
                  Text(
                       "${Tools.month[int.parse(allEvents[i].e_date.toString().substring(5, 7))-1]}",
                      
                        style: TextStyle(color: Colors.grey),
                      ),
                  /* Text(
                    ".",
                    //"${allEvents[i].e_start_time.toString().substring(0, 5)}",
                    style: TextStyle(color: Colors.grey[600]),
                  ), */
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.angleRight,
                    color: Tools.multiColors[4],
                  ),
                  /*  SizedBox(
                height: 5,
              )
              ,
              Text(
                "-->",
                style: TextStyle(color: Colors.red),
              ) */
                ],
              ),
              /*  trailing: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      "${allEvents[i].e_start_time.toString().substring(0, 5)} to ",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text:
                          "${allEvents[i].e_end_time.toString().substring(0, 5)}\n",
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ), */

              /* leading: Hero(tag: "${allEvents[i].e_title}\n",
                child: CircleAvatar(radius: 30,
                      child: Image.asset('assets/images/ca.png'),
                  //backgroundImage:  CachedNetworkImageProvider('https://www.flaticon.com/authors/alfredo-hernandez'),
                ),
              ), */
              title: RichText(
                text: TextSpan(
                  text: "${allEvents[i].e_title}",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    /*   WidgetSpan(
                      child: Icon(Icons.add_location,size: 18,)
                    ), */
                    /*       TextSpan(
                        text: "${allEvents[i].e_venue}",
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                              fontSize: 14,
                              color: Tools.multiColors[Random().nextInt(4)],
                            ),
                        children: []), */
                  ],
                ),
              ),
              subtitle: Text(
                allEvents[i].e_description.toString(), maxLines: 4,
                // 20 <=allEvents[i].e_description.toString().length?"${allEvents[i].e_description.toString().substring(0,30)}":"${allEvents[i].e_description.toString().substring(0,20)}",
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14.0,
                    ),
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
