import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screen/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Job Finder app',
        theme: ThemeData(
          primaryColor: Color(0xFF438187),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFED408))
        ),
        home: HomePage());
  }
}
