import 'package:anet/models/events.dart';
import 'package:anet/models/news_model.dart';
import 'package:anet/models/project_model.dart';
import 'package:anet/models/stat.dart';
import 'package:equatable/equatable.dart';
import 'package:anet/home/session.dart';
import 'package:anet/home/speaker.dart';
import 'package:anet/home/team.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState extends Equatable {
  HomeState([Iterable props]) : super(props);

  /// Copy object for use in action
  HomeState getStateCopy();
}

/// UnInitialized
class UnHomeState extends HomeState {
  @override
  String toString() => 'UnHomeState';

  @override
  HomeState getStateCopy() {
    return UnHomeState();
  }
}

/// Initialized
class InHomeState extends HomeState {
  //final SpeakersData speakersData;
  //final SessionsData sessionsData;
//  final TeamsData teamsData;
  final EventsData eventsData;
  final NewsData newsData;
  final Stats stats;
  final ProjectData projectData;
  final String username;

  InHomeState(
      {@required this.eventsData,
      @required this.newsData,
      //@required this.speakersData,
      //  @required this.sessionsData,
      // @required this.teamsData,
      @required this.stats,
      @required this.projectData,
      @required this.username})
      : super([
          eventsData,
          newsData,
          //  speakersData,
          //sessionsData,
          stats,
          projectData,
          username,
        ]);
  @override
  String toString() => 'InHomeState';

  @override
  HomeState getStateCopy() {
    return InHomeState(
        eventsData: this.eventsData,
        newsData: this.newsData,
        // speakersData: this.speakersData,
        // sessionsData: this.sessionsData,
        // teamsData: this.teamsData,
        stats: this.stats,
        projectData: this.projectData,
        username: username);
  }
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(this.errorMessage);

  @override
  String toString() => 'ErrorHomeState';

  @override
  HomeState getStateCopy() {
    return ErrorHomeState(this.errorMessage);
  }
}
