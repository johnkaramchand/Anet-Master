class ProjectData {

  List <Project> project;

  ProjectData({
    this.project
  });
  
  ProjectData.fromJson(List < dynamic > json) {
    project = new List < Project > ();
    for (var v in json) {
      project.add(Project.fromJson(v));
    }
    print(project);
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    if (this.project != null) {
      data['project'] = this.project.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Project {
  int p_id;
  bool p_state;
  String p_title;
  String p_image;
  String p_datetime;
  String p_desc;
  String p_medium_link;
  String p_github_link;
  String p_apply_link;
  int u_id;



  Project({
    this.p_id,
    this.p_state,
    this.p_title,
    this.p_image,
    this.p_datetime,
    this.p_desc,
    this.p_medium_link,
    this.p_github_link,
    this.p_apply_link,
    this.u_id,
  });

  Project.fromJson(Map < String, dynamic > json) {
    p_id = json['p_id'];
    p_state = json['p_state'];
    p_title = json['p_title'];
    p_image = json['p_image'];
    p_datetime = json['p_datetime'];
    p_desc = json['p_desc'];
    p_medium_link = json['p_medium_link'];
    p_github_link = json['p_github_link'];
    p_apply_link = json['p_apply_link'];
    u_id = json['u_id'];
    
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    data['p_id'] = this.p_id;
    data['p_state'] = this.p_state;
    data['p_title'] = this.p_title;
    data['p_image'] = this.p_image;
    data['p_datetime'] = this.p_datetime;
    data['p_desc'] = this.p_desc;
    data['p_medium_link'] = this.p_medium_link;
    data['p_github_link'] = this.p_github_link;
    data['p_apply_link'] = this.p_apply_link;
    data['u_id'] = this.u_id;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/