import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:discoballlaserbeam/ui/screen/captainlog.dart';
import 'package:discoballlaserbeam/ui/screen/finalcountdown.dart';
import 'package:discoballlaserbeam/ui/screen/login.dart';
import 'package:discoballlaserbeam/ui/screen/settings.dart';
import '../common/sign_in.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseUser currentUser;

  @override
  initState() {
    getCurrentUser().then((result) => {
      setState(() {
        this.currentUser = result;
      })
    });
    super.initState();
  }

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(child: Text("Header"));
    var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      headerChild,

      getNavItem(Icons.home, "Home", "/"),
      getNavItem(Icons.collections_bookmark, "Captain's Log", CaptainScreen.routeName),
      getNavItem(Icons.access_alarms, "Final Countdown", CountdownScreen.routeName),
      getNavItem(Icons.lock_open, "Login/out", LoginScreen.routeName),
      getNavItem(Icons.settings, "Settings", SettingsScreen.routeName),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      name = "New User";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("DiscoballLaserbeam"),
      ),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
            ]
          )),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}