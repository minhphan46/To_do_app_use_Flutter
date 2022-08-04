import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class Task {
  late String content;
  bool? isChecked;
  DateTime createTime;
  //constructor
  Task({
    this.content = "",
    this.isChecked = false,
    DateTime? createTime,
  }) : this.createTime = createTime ?? DateTime.now();

  //methor
  @override
  String toString() {
    // TODO: implement toString
    return "Content: ${content}, check: ${isChecked}";
  }
}
