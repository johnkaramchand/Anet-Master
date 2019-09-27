import 'package:anet/home/session.dart';
import 'package:anet/home/speaker.dart';
import 'package:anet/home/team.dart';
import 'package:anet/models/project_model.dart';
import 'package:anet/models/stat.dart';
import 'package:anet/network/i_client.dart';
import 'package:anet/utils/dependency_injection.dart';
import 'package:anet/utils/devfest.dart';
import 'package:anet/models/events.dart';
import 'package:anet/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();
  Future<SessionsData> getSessions();
  //Future<TeamsData> getTeams();
  Future<EventsData> getEvents();
  Future<NewsData> getNews();
  Future<Stats> getStats();
  Future<ProjectData> getProjects();
}

class HomeProvider implements IHomeProvider {
  IClient _client;

  static final String kConstGetSpeakersUrl =
      "${Devfest.baseUrl}/speaker-kol.json";

  //! Not Working
  static final String kConstGetSessionsUrl =
      "${Devfest.baseUrl}/session-kol.json";

  //! Not Working
  static final String kConstGetTeamsUrl = "${Devfest.baseUrl}/team-kol.json";

  HomeProvider() {
    _client = Injector().currentClient;
  }

  Future<NewsData> getNews() async {
    final response =
        await http.get('http://139.59.61.35:8000/api/v2/news/?format=json');
    if (response.statusCode == 200) {
      print(response.body);
      NewsData res = NewsData.fromJson(json.decode(response.body));
      return res;
    } else
      throw Exception('Failed to load events');
  }

    Future<ProjectData> getProjects() async {
    final response =
        await http.get('http://139.59.61.35:8000/api/v2/getProjects/?format=json');
    if (response.statusCode == 200) {
      print(response.body);
      ProjectData res = ProjectData.fromJson(json.decode(response.body));
      return res;
    } else
      throw Exception('Failed to load events');
  }

  Future<EventsData> getEvents() async {
    final response =
        await http.get('http://139.59.61.35:8000/api/v2/events/?format=json');
    if (response.statusCode == 200) {
      EventsData res = EventsData.fromJson(json.decode(response.body));
      print("RES : ${res.events[0].e_organizer}");
      return res;
    } else
      throw Exception('Failed to load events');
  }

  @override
  Future<SpeakersData> getSpeakers() async {
    var result = await _client.getAsync(kConstGetSpeakersUrl);
    if (result.networkServiceResponse.success) {
      SpeakersData res = SpeakersData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<SessionsData> getSessions() async {
    var result = await _client.getAsync(kConstGetSessionsUrl);
    if (result.networkServiceResponse.success) {
      SessionsData res = SessionsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }

  @override
  Future<Stats> getStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = await prefs.getString('communitiesinatria-token');
    String token = stringValue;
    print("INSIDE GET STATS");
    Map<String, String> headers = {"Content-type": "application/json"};
    var response;
    String jsonRequest =
        '{"token": "$token"}';
    //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
    // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
    // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;

    response = await http.post('http://139.59.61.35:8000/api/v2/getstats/',
        body: jsonRequest, headers: headers);
    print("THIS IS RESPONSE ${response.body}");
    if (json.decode(response.body)['response'] == false) {
      throw Exception('Failed to load Stats');
    }
    Stats res = Stats.fromJson(json.decode(response.body));
    print("THIS IS $res");
    return res;

    //print(response.body);

    /*  var result = await _client.getAsync(kConstGetTeamsUrl);
    if (result.networkServiceResponse.success) {
      TeamsData res = TeamsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message); */
  }
}
