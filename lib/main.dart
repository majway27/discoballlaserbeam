
import 'package:flutter/material.dart';
import 'package:discoballlaserbeam/ui/screen/babynames.dart';
import 'package:discoballlaserbeam/ui/screen/captainlog.dart';
import 'package:discoballlaserbeam/ui/screen/finalcountdown.dart';
import 'package:discoballlaserbeam/ui/screen/home.dart';
import 'package:discoballlaserbeam/ui/screen/settings.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(), // route for home is '/' implicitly
    routes: <String, WidgetBuilder>{
      // define the routes
      BabyScreen.routeName: (BuildContext context) => BabyScreen(),
      CaptainScreen.routeName: (BuildContext context) => CaptainScreen(),
      CountdownScreen.routeName: (BuildContext context) => CountdownScreen(),
      SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
    },
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Color(0xFF0D1321),
      accentColor: Color(0xFF8E1B1B),

      // Define the default font family.
      fontFamily: 'Georgia',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    )
  ));
}