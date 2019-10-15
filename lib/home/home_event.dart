import 'dart:async';
import 'package:anet/home/home_provider.dart';
import 'package:anet/home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    var eventsData = await _homeProvider.getEvents();
    var newsData = await _homeProvider.getNews();
    // var speakersData = await _homeProvider.getSpeakers();
    //var sessionsData = await _homeProvider.getSessions();
    //var teamsData = await _homeProvider.getTeams();
    var stats = await _homeProvider.getStats();
    var projectsData = await _homeProvider.getProjects();
    var username = await _homeProvider.getUsername();

    try {
      var eventsData = await _homeProvider.getEvents();
      var newsData = await _homeProvider.getNews();
      // var speakersData = await _homeProvider.getSpeakers();
      //var sessionsData = await _homeProvider.getSessions();
      //var teamsData = await _homeProvider.getTeams();
      var stats = await _homeProvider.getStats();
      var projectsData = await _homeProvider.getProjects();
      var username = await _homeProvider.getUsername();

      print("\n\n\n\nABOUT TO RETURN IN HOME");
      return InHomeState(
          eventsData: eventsData,
          newsData: newsData,
          //  speakersData: speakersData,
          //  sessionsData: sessionsData,

          //  teamsData: teamsData,
          stats: stats,
          projectData: projectsData,
          username: username);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
    return InHomeState(
        newsData: newsData,
        eventsData: eventsData,
        stats: stats,
        projectData: projectsData,
        username: username);
  }
}
/* 
class LoadEventsEvent extends HomeEvent {
  final IHomeProvider _homeProvider = HomeProvider();
  @override
  String toString() => 'LoadEventsEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {

      var eventsData = await _homeProvider.getEvents();
      var speakersData = await _homeProvider.getSpeakers();
      var sessionsData = await _homeProvider.getSessions();
      var teamsData = await _homeProvider.getTeams();
      var newsData = await _homeProvider.getNews();
      return InHomeState(
        eventsData: eventsData,
        newsData: newsData,
        speakersData: speakersData,
        sessionsData: sessionsData,
        teamsData: teamsData,
      );
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      return ErrorHomeState(_?.toString());
    }
  }
} */
