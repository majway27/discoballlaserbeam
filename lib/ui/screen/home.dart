import 'package:flutter/material.dart';
import 'package:discoballlaserbeam/ui/screen/babynames.dart';
import 'package:discoballlaserbeam/ui/screen/captainlog.dart';
import 'package:discoballlaserbeam/ui/screen/finalcountdown.dart';
import 'package:discoballlaserbeam/ui/screen/settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
      getNavItem(Icons.account_box, "Baby", BabyScreen.routeName),
      getNavItem(Icons.collections_bookmark, "Captain's Log", CaptainScreen.routeName),
      getNavItem(Icons.access_alarms, "Final Countdown", CountdownScreen.routeName),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("DiscoballLaserbeam"),
      ),
      body: Container(
          child: Center(
            child: Text("Home Screen"),
          )),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}