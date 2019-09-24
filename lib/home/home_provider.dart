import 'package:anet/home/session.dart';
import 'package:anet/home/speaker.dart';
import 'package:anet/home/team.dart';
import 'package:anet/network/i_client.dart';
import 'package:anet/utils/dependency_injection.dart';
import 'package:anet/utils/devfest.dart';
import 'package:anet/models/events.dart';
import 'package:anet/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


abstract class IHomeProvider {
  Future<SpeakersData> getSpeakers();
  Future<SessionsData> getSessions();
  Future<TeamsData> getTeams();
  Future<EventsData> getEvents();
  Future<NewsData> getNews();
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

  Future<NewsData> getNews() async{
    final response = await http.get('http://139.59.61.35:8000/api/v2/events/?format=json');
    if(response.statusCode == 200){
      print(response.body);
      NewsData res =  NewsData.fromJson(json.decode(response.body));
      return res;
    }
    else
    throw Exception('Failed to load events');
  }



  Future<EventsData> getEvents() async{
    final response = await http.get('http://139.59.61.35:8000/api/v2/events/?format=json');
    if(response.statusCode == 200){
        
        
      
      EventsData res =  EventsData.fromJson(json.decode(response.body));
      print("RES : ${res.events[0].e_organizer}");
      return res;
    }
    else
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
  Future<TeamsData> getTeams() async {
    var result = await _client.getAsync(kConstGetTeamsUrl);
    if (result.networkServiceResponse.success) {
      TeamsData res = TeamsData.fromJson(result.mappedResult);
      return res;
    }

    throw Exception(result.networkServiceResponse.message);
  }
}
