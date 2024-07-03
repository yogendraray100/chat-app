class UserModel {
  final String name;
  final String uid;
  final String phoneNumber;

  UserModel({required this.name, required this.uid, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
