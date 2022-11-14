import 'package:cloud_firestore/cloud_firestore.dart';

const defaultAvatar =
    "https://firebasestorage.googleapis.com/v0/b/spending-management-c955a.appspot.com/o/FVK7wz5aIAA25l8.jpg?alt=media&token=ddceb8f7-7cf7-4c42-a806-5d0d48ce58f5";

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
