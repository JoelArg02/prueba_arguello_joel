class UserModel {
  final String uid;
  final String? name;
  final String phone;

  UserModel({required this.uid, this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
    );
  }
}
