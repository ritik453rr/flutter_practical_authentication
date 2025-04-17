class UserModel {
  String uid;
  String userName;
  String? email;
  String? phone;
  String? address;
  String? profilePicture;

  UserModel({
    required this.uid,
    required this.userName,
    this.email,
    this.phone,
    this.address,
    this.profilePicture,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : uid = json['id'] as String,
        userName = json['name'] as String,
        email = json['email'],
        phone = json['phone'],
        address = json['address'],
        profilePicture = json['profile_picture'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = uid;
    data['name'] = userName;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['profile_picture'] = profilePicture;
    return data;
  }
}