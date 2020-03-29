class  LoginSuperSaiyanResponse{
  String access_token;
  String token_type;
  String refresh_token;
  int expires_in;
  String scope;

  LoginSuperSaiyanResponse({
    this.access_token,
    this.token_type,
    this.refresh_token,
    this.expires_in,
    this.scope
  });

  LoginSuperSaiyanResponse.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    token_type = json['token_type'];
    refresh_token = json['userefresh_tokenrname'];
    expires_in = json['expires_in'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    data['token_type'] = this.token_type;
    data['refresh_token'] = this.refresh_token;
    data['expires_in'] = this.expires_in;
    data['scope'] = this.scope;

    return data;
  }
}
