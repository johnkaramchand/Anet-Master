class EventsData {

  List < Event > events;

  EventsData({
    this.events
  });
  
  EventsData.fromJson(List < dynamic > json) {
    events = new List < Event > ();
    for (var v in json) {
      events.add(Event.fromJson(v));
    }
    print(events);
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  int e_id;
  bool e_state;
  String e_title;
  String e_date;
  String e_start_time;
  String e_end_time;
  String e_venue;
  int e_organizer;
  String e_description;
  int e_score;
  String e_registration_link;
  String e_photos_link;
  String e_medium_link;



  Event({
    this.e_id,
    this.e_state,
    this.e_title,
    this.e_date,
    this.e_start_time,
    this.e_end_time,
    this.e_venue,
    this.e_organizer,
    this.e_description,
    this.e_score,
    this.e_registration_link,
    this.e_photos_link,
    this.e_medium_link,
  });

  Event.fromJson(Map < String, dynamic > json) {
    e_id = json['e_id'];
    e_state = json['e_state'];
    e_title = json['e_title'];
    e_date = json['e_date'];
    e_start_time = json['e_start_time'];
    e_end_time = json['e_end_time'];
    e_venue = json['e_venue'];
    e_organizer = json['e_organizer'];
    e_description = json['e_description'];
    e_score = json['e_score'];
    e_registration_link = json['e_registration_link'];
    e_photos_link = json['e_photos_link'];
    e_medium_link = json['e_medium_link'];
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    data['e_id'] = this.e_id;
    data['e_state'] = this.e_state;
    data['e_title'] = this.e_title;
    data['e_date'] = this.e_date;
    data['e_start_time'] = this.e_start_time;
    data['e_end_time'] = this.e_end_time;
    data['e_venue'] = this.e_venue;
    data['e_organizer'] = this.e_organizer;
    data['e_description'] = this.e_description;
    data['e_score'] = this.e_score;
    data['e_registration_link'] = this.e_registration_link;
    data['e_photos_link'] = this.e_photos_link;
    data['e_medium_link'] = this.e_medium_link;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/