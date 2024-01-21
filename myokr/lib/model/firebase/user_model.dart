class UserData {
  String? uid;
  String? email;
  String? name;

  UserData({
    required this.uid,
    required this.email,
    required this.name,
  });

  UserData.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] ?? "",
        email = map['email'] ?? "",
        name = map['name'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
