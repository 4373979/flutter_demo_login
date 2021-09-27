class PublicKeyModel {
  List keys;

  PublicKeyModel.fromJson(Map<String, dynamic> json)
      : keys = json['keys'];

  Map<String, dynamic> toJson() => {
    'keys': keys
  };

  @override
  String toString() {
    return '$keys';
  }
}
