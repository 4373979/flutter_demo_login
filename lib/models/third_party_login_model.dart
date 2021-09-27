class ThirdPartyLoginModel {
  String loginType;
  String loginToken;

  ThirdPartyLoginModel(this.loginType, this.loginToken);

  ThirdPartyLoginModel.fromJson(Map<String, dynamic> json)
      : loginType = json['loginType'],
        loginToken = json['loginToken'];

  Map<String, dynamic> toJson() => {
    'loginType': loginType,
    'loginToken': loginToken
  };

  @override
  String toString() {
    return '{"loginType": "$loginType", "loginToken": "$loginToken"}';
  }
}
