class NewsData {
  List<News> news;

  NewsData({this.news});

  //EventsData.fromJson(Map<String, dynamic> json) {
  NewsData.fromJson(List<dynamic> json) {
    //if (json['events'] != null) {
    print("Inside");
    news = new List<News>();
    for (var v in json) {
      news.add(News.fromJson(v));
    }
    print(news);
    /*
      json['events'].forEach((v) {
        events.add(Event.fromJson(v));
      });*/
    //}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['events'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  int n_id;
  String n_title;
  String n_desc;
  int n_author;
  String n_datetime;
  String n_image;
  String n_link;

  News(
      {this.n_id,
      this.n_title,
      this.n_desc,
      this.n_author,
      this.n_datetime,
      this.n_image,
      this.n_link});

  News.fromJson(Map<String, dynamic> json) {
    n_id = json['n_id'];
    n_title = json['n_title'];
    n_desc = json['n_desc'];
    n_author = json['n_author'];
    n_datetime = json['n_datetime'];
    n_image = json['n_image'];
    n_link = json['n_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_id'] = this.n_id;
    data['n_title'] = this.n_title;
    data['n_desc'] = this.n_desc;
    data['n_author'] = this.n_author;
    data['n_datetime'] = this.n_datetime;
    data['n_image'] = this.n_image;
    data['n_link'] = this.n_link;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/
