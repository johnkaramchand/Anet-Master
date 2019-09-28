class LoginResponse {
  String key;
  String status;
  String username;
  String email;

  LoginResponse({
    this.key,
    this.status,
    this.username,
    this.email,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    status = json['status'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['status'] = this.status;
    data['username'] = this.username;
    data['email'] = this.email;

    return data;
  }
}
/*
List<Event> events = [
  Event(
  ),
];
*/
