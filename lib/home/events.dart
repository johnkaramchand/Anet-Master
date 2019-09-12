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
  String event_type;
  String title;
  String event_date;
  String start_time;
  String end_time;
  String venue;
  String organizer;
  String description;
  

  Event(
      {this.event_id,
      this.event_type,
      this.title,
      this.event_date,
      this.start_time,
      this.end_time,
      this.venue,
      this.organizer,
      this.description,});

  Event.fromJson(Map<String, dynamic> json) {
    event_id = json['event_id'];
    event_type = json['event_type'];
    title = json['title'];
    event_date = json['event_date'];
    start_time = json['start_time'];
    end_time = json['end_time'];
    venue = json['venue'];
    organizer = json['organizer'];
    description = json['description'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.event_id;
    data['event_type'] = this.event_type;
    data['title'] = this.title;
    data['event_date'] = this.event_date;
    data['start_time'] = this.start_time;
    data['end_time'] = this.end_time;
    data['venue'] = this.venue;
    data['organizer'] = this.organizer;
    data['description'] = this.description;
  
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/