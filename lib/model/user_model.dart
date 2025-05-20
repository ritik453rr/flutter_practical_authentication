class UserModel {
  String uid;
  String name;
  String email;
  String profileUrl;

  UserModel({
    this.uid = "",
    this.name = "",
    this.email = "",
    this.profileUrl = "",
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String,
        name = json['name'] as String,
        email = json['email'],
        profileUrl = json['profileUrl'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['profileUrl'] = profileUrl;
    return data;
  }
}
