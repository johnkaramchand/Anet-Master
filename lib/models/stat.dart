class Stats {
  int score_sum;
  bool response;
  int total_count;

  Stats({
    this.score_sum,
    this.response,
    this.total_count,
    
  });

  Stats.fromJson(Map<String, dynamic> json) {
    score_sum = json['score_sum'];
    response = json['response'];
    total_count = json['total_count'];
   
  }

  Map < String, dynamic > toJson() {
    final Map < String, dynamic > data = new Map < String, dynamic > ();
    data['score_sum'] = this.score_sum;
    data['response'] = this.response;
    data['total_count'] = this.total_count;
    
    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/