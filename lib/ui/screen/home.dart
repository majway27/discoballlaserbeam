import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
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
  List <Color> _colors = [Color(0xFF0D1321), Colors.transparent];
  String captainlogEntryCountStat;
  String captainlogLastEntryStat;

  @override
  initState() {
    getCurrentUser().then((result) => {
      setState(() {
        this.currentUser = result;
      }),
      getStats().then((result) => {
        setState(() {
          this.captainlogEntryCountStat =
              result.documents[0].data['entries'].toString();
          this.captainlogLastEntryStat =
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.fromMillisecondsSinceEpoch(
                  result.documents[0].data['lastupdate']));
        })
      })
    });
    super.initState();
  }

  Future <QuerySnapshot> getStats() async {
    return await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .collection('stats')
        .getDocuments();
  }

  Drawer getNavDrawer(BuildContext context) {
    var headerChild = DrawerHeader(child: Text("Header"));

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
      getNavItem(Icons.settings, "Settings", SettingsScreen.routeName),
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
    if (captainlogEntryCountStat == null) {
      captainlogLastEntryStat = 'Loading';
      captainlogEntryCountStat = 'Loading';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("DiscoballLaserbeam"),
      ),
      body: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]),
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: LinearGradient(
                      colors: _colors,
                      begin:  Alignment.topLeft,
                      end:  Alignment.bottomRight,
                    )
                ),
                margin: const EdgeInsets.fromLTRB(10,10,10,5),
                child: Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Colors.grey[600],
                                  height: 50,
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text('Welcome,  '),
                                                    Text(name,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white)),
                                                  ],
                                                ),
                                              ]
                                          ),
                                        )
                                      ], //Children
                                    ),
                                  ),
                                ),
                              ],
                            ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsScreen()));
                              } //onPressed
                          )
                      ),
                    ]
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]),
                    borderRadius: BorderRadius.circular(5.0),
                    gradient: LinearGradient(
                      colors: _colors,
                      begin:  Alignment.topLeft,
                      end:  Alignment.bottomRight,
                    )
                ),
                margin: const EdgeInsets.fromLTRB(10,10,10,5),
                child: Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Theme.of(context).accentColor,
                                  height: 90,
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                                      child: Text("Captain's Log"),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text("Last Log Entry:  ",
                                                        style: TextStyle(
                                                          color: Colors.white)),
                                                    Text(captainlogLastEntryStat,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Theme.of(context).accentColor)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text("Total Entries:  ",
                                                        style: TextStyle(
                                                            color: Colors.white)),
                                                    Text(captainlogEntryCountStat,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Theme.of(context).accentColor)),
                                                  ],
                                                ),
                                              ]
                                          ),
                                        )
                                      ], //Children
                                    ),
                                  ),
                                ),
                              ],
                            ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CaptainScreen()));
                              } //onPressed
                          )
                      ),
                    ]
                ),
              ),
            ],
          )),
      // Set the nav drawer
      drawer: getNavDrawer(context),
    );
  }
}