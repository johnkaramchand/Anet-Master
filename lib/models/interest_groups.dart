import 'package:anet/home/session.dart';

class InterestGroups {

  List <InterestGroup> interestgroup;

  InterestGroups({
    this.interestgroup
  });
  
  InterestGroups.fromJson(List < dynamic > json) {
    interestgroup = new List < InterestGroup > ();
    for (var v in json) {
      interestgroup.add(InterestGroup.fromJson(v));
    }
    print(interestgroup);
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    if (this.interestgroup != null) {
      data['project'] = this.interestgroup.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InterestGroup {
  int id;
  String g_name;
  String g_desc;
  String g_img;
  int g_head;
  String g_tellink;
  String g_medium;

  InterestGroup({
    this.id,
    this.g_name,
    this.g_desc,
    this.g_img,
    this.g_head,
    this.g_tellink,
    this.g_medium,
  });

  InterestGroup.fromJson(Map < String, dynamic > json) {
    id = json['id'];
    g_name = json['g_name'];
    g_desc = json['g_desc'];
    g_img = json['g_img'];
    g_head = json['g_head'];
    g_tellink = json['g_tellink'];
    g_medium = json['g_medium'];
    
    
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    data['id'] = this.id;
    data['g_name'] = this.g_name;
    data['g_desc'] = this.g_desc;
    data['g_img'] = this.g_img;
    data['g_head'] = this.g_head;
    data['g_tellink'] = this.g_tellink;
    data['g_medium'] = this.g_medium;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/