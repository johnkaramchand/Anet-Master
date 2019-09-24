import 'package:flutter/material.dart';
//import 'package:anet/agenda/session_list.dart';
import 'package:anet/home/index.dart';
import 'event_list.dart';

class PastEventsScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  const PastEventsScreen({Key key, this.homeBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var state = homeBloc.currentState as InHomeState;
    var events = state.eventsData.events;
    var eventSessions = events.where((s) => s.e_state == false).toList();
    return EventList(
      allEvents: eventSessions,
    );
  }
}
