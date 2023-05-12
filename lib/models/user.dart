import 'package:cloud_firestore/cloud_firestore.dart';

const defaultAvatar = "";

class User {
  String name;
  String birthday;
  String avatar;
  bool gender;
  int money;

  User(
      {required this.name,
      required this.birthday,
      required this.avatar,
      required this.money,
      this.gender = true});

  Map<String, dynamic> toMap() => {
        "name": name,
        "birthday": birthday,
        "avatar": avatar,
        "gender": gender,
        "money": money
      };

  factory User.fromFirebase(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
      name: data["name"],
      birthday: data["birthday"],
      avatar: data["avatar"],
      money: data["money"],
      gender: data['gender'] as bool,
    );
  }

  User copyWith(
      {String? name,
      String? birthday,
      String? avatar,
      bool? gender,
      int? money}) {
    return User(
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      avatar: avatar ?? defaultAvatar,
      money: money ?? this.money,
      gender: gender ?? this.gender,
    );
  }
}
