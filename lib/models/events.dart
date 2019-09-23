class EventsData {
  List<Event> events;

  EventsData({this.events});

  //EventsData.fromJson(Map<String, dynamic> json) {
    EventsData.fromJson(List<dynamic> json) {
    //if (json['events'] != null) {
      print("Inside");
      events = new List<Event>();
      for(var v in json){
         events.add(Event.fromJson(v));
      }
      print(events);
            /*
      json['events'].forEach((v) {
        events.add(Event.fromJson(v));
      });*/
    //}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  int event_id;
  bool event_state;
  String title;
  String event_date;
  String start_time;
  String end_time;
  String venue;
  String organizer;
  String description;
  String registration_link;
  String photos_link;
  String medium_link;

  

  Event(
      {this.event_id,
      this.event_state,
      this.title,
      this.event_date,
      this.start_time,
      this.end_time,
      this.venue,
      this.organizer,
      this.description,
      this.registration_link,
      this.photos_link,
      this.medium_link});

  Event.fromJson(Map<String, dynamic> json) {
    event_id = json['event_id'];
    event_state = json['event_state'];
    title = json['title'];
    event_date = json['event_date'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    venue = json['venue'];
    organizer = json['organizer'];
    description = json['description'];
    registration_link = json['registration_link'];
    photos_link = json['photos_link'];
    medium_link = json['medium_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.event_id;
    data['event_state'] = this.event_state;
    data['title'] = this.title;
    data['event_date'] = this.event_date;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;
    data['venue'] = this.venue;
    data['organizer'] = this.organizer;
    data['description'] = this.description;
    data['registration_link'] = this.registration_link;
    data['photos_link'] = this.photos_link;
    data['medium_link'] = this.medium_link;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/