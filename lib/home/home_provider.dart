import 'package:anet/models/project_model.dart';
import 'package:anet/models/stat.dart';
import 'package:anet/models/events.dart';
import 'package:anet/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class IHomeProvider {
  //Future<TeamsData> getTeams();
  Future<EventsData> getEvents();
  Future<NewsData> getNews();
  Future<Stats> getStats();
  Future<ProjectData> getProjects();
  Future<String> getUsername();
}

class HomeProvider implements IHomeProvider {
  Future<NewsData> getNews() async {
    final response =
        await http.get('http://test.ciadev.ninja/api/v2/news/?format=json');
    if (response.statusCode == 200) {
      print(response.body);
      NewsData res = NewsData.fromJson(json.decode(response.body));
      return res;
    } else
      throw Exception('Failed to load events');
  }

  Future<ProjectData> getProjects() async {
    final response =
        await http.get('http://test.ciadev.ninja/api/v2/getProjects/?format=json');
    if (response.statusCode == 200) {
      print(response.body);
      ProjectData res = ProjectData.fromJson(json.decode(response.body));
      return res;
    } else
      throw Exception('Failed to load events');
  }

  Future<EventsData> getEvents() async {
    final response =
        await http.get('http://test.ciadev.ninja/api/v2/events/?format=json');
    if (response.statusCode == 200) {
      EventsData res = EventsData.fromJson(json.decode(response.body));
      print("RES : ${res.events[0].e_organizer}");
      return res;
    } else
      throw Exception('Failed to load events');
  }

  Future<String> getUsername() async {
    print("\n\n\n TO GET USER \n\n");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    return prefs.getString('communitiesinatria-username');
  }

  @override
  Future<Stats> getStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = await prefs.getString('communitiesinatria-token');
    String token = stringValue;
    print("INSIDE GET STATS");
    print(token);
    Map<String, String> headers = {"Content-type": "application/json"};
    var response;
    String jsonRequest = '{"token": "$token"}';
    //  String jsonRequest = '{"username": "$username", "email": "$email", "password":"$password"}';
    // String jsonRequest = '{"username": "test1", "email": "test@gmail.com", "password":"whatbro1"}';
    // await Future.delayed(Duration(seconds: 1)) ;
    //return 'token' ;

    response = await http.post('http://test.ciadev.ninja/api/v2/getstats/',
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
