import 'package:flutter/material.dart';

class Filter {
  List<int> chooseIndex;
  int money;
  int finishMoney;
  DateTime? time;
  DateTime? finishTime;
  String note;
  List<Color>? colors;
  List<String>? friends;

  Filter({
    required this.chooseIndex,
    this.money = 0,
    this.finishMoney = 0,
    this.time,
    this.finishTime,
    this.note = "",
    this.colors,
    this.friends,
  });

  Filter copyWith({
    List<int>? chooseIndex,
    int? money,
    int? finishMoney,
    DateTime? time,
    DateTime? finishTime,
    String? note,
    List<Color>? colors,
    List<String>? friends,
  }) {
    return Filter(
      chooseIndex: chooseIndex ?? List.from(this.chooseIndex),
      money: money ?? this.money,
      finishMoney: finishMoney ?? this.finishMoney,
      time: time ?? this.time,
      finishTime: finishTime ?? this.finishTime,
      note: note ?? this.note,
      colors: colors ?? this.colors,
      friends: friends ?? this.friends,
    );
  }
}
