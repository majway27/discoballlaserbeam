import 'package:flutter/material.dart';

import 'package:discoballlaserbeam/ui/screen/captainlog.dart';
import 'package:discoballlaserbeam/ui/screen/finalcountdown.dart';
import 'package:discoballlaserbeam/ui/screen/home.dart';
import 'package:discoballlaserbeam/ui/screen/login.dart';
import 'package:discoballlaserbeam/ui/screen/settings.dart';
import 'package:discoballlaserbeam/ui/common/base.dart';
import 'package:discoballlaserbeam/data/services/auth.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new BaseScreen(auth: new Auth()),
    routes: <String, WidgetBuilder>{
      // define the routes
      CaptainScreen.routeName: (BuildContext context) => CaptainScreen(),
      CountdownScreen.routeName: (BuildContext context) => CountdownScreen(),
      HomeScreen.routeName: (BuildContext context) => HomeScreen(),
      LoginScreen.routeName: (BuildContext context) => LoginScreen(),
      SettingsScreen.routeName: (BuildContext context) => SettingsScreen(),
    },
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Color(0xFF0D1321),
      accentColor: Color(0xFF8E1B1B),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0),
      ),
    )
  ));
}