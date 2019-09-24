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
    try {

      var eventsData = await _homeProvider.getEvents();
      var newsData = await _homeProvider.getNews();
      var speakersData = await _homeProvider.getSpeakers();
      var sessionsData = await _homeProvider.getSessions();
      var teamsData = await _homeProvider.getTeams();

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
}

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
}