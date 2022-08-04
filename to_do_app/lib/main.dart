import 'package:flutter/material.dart';
import 'myapp.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "To do list app",
    theme: ThemeData(
      primaryColor: Color(0xff48cae4),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Color(0xff0096c7),
        tertiary: Colors.black,
      ),
    ),
    home: MyApp(),
  ));
}
