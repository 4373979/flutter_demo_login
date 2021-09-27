class UserInfoModel {
  String? iss;
  String? sub;
  String? aud;
  int? exp;
  int? iat;
  String? username;
  String? name;
  String? picture;
  String? email;

  UserInfoModel(this.iss, this.sub, this.aud, this.exp, this.iat, this.username, this.name, this.picture, this.email);

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : iss = json['iss'],
        sub = json['sub'],
        aud = json['aud'],
        exp = json['exp'],
        iat = json['iat'],
        username = json['username'],
        name = json['name'],
        picture = json['picture'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'iss': iss,
    'sub': sub,
    'aud': aud,
    'exp': exp,
    'iat': iat,
    'username': username,
    'name': name,
    'picture': picture,
    'email': email
  };

  @override
  String toString() {
    return '{"iss": "$iss", "sub": "$sub", "aud": "$aud", "exp": "$exp", "iat": "$iat", "username": "$username", "name": "$name", "picture": "$picture", "email": "$email"}';
  }
}
