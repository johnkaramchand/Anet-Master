class NewsData {
  List<News> news;

  NewsData({this.news});

  //EventsData.fromJson(Map<String, dynamic> json) {
    NewsData.fromJson(List<dynamic> json) {
    //if (json['events'] != null) {
      print("Inside");
      news = new List<News>();
      for(var v in json){
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
  int news_id;
  String news_title;
  String news_author;
  String news_datetime;
  String news_image;
  

  News(
      {this.news_id,
      this.news_title,
      this.news_author,
      this.news_datetime,
      this.news_image});

  News.fromJson(Map<String, dynamic> json) {
    news_id = json['news_id'];
    news_title = json['news_title'];
    news_author = json['news_author'];
    news_datetime = json['news_datetime'];
    news_image = json['news_image'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.news_id;
    data['news_title'] = this.news_title;
    data['news_author'] = this.news_author;
    data['news_datetime'] = this.news_datetime;
    data['news_image'] = this.news_image;
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/