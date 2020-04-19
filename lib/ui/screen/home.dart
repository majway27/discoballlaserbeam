import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:discoballlaserbeam/ui/screen/captainlog.dart';
import 'package:discoballlaserbeam/ui/screen/finalcountdown.dart';
import 'package:discoballlaserbeam/ui/screen/settings.dart';
import 'package:discoballlaserbeam/data/services/auth.dart';
import '../common/logCard.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  HomeScreen({Key key, this.auth, this.uid, this.logoutCallback}) : super(key: key);
  final Auth auth;
  final VoidCallback logoutCallback;
  final String uid;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Color> _colors = [Color(0xFF0D1321), Colors.transparent];

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                  child: Icon(
                                      Icons.settings,
                                      size: 15.0,
                                      color: Theme.of(context).primaryColor,
                                  ),
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
                                                    Text(widget.auth.name,
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
                                            SettingsScreen(auth: widget.auth, uid: widget.uid)));
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
                                  child: Icon(
                                    Icons.collections_bookmark,
                                    size: 15.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
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
                                                    StreamBuilder<QuerySnapshot>(
                                                        stream: Firestore.instance.collection('users').document(widget.uid).collection('stats').snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if(snapshot.data == null) return CircularProgressIndicator();
                                                          return new Text(DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(
                                                              snapshot.data.documents[0].data['lastupdate'])),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Theme.of(context).accentColor)
                                                          );
                                                        }
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text("Total Entries:  ",
                                                        style: TextStyle(
                                                            color: Colors.white)),
                                                    StreamBuilder<QuerySnapshot>(
                                                      stream: Firestore.instance.collection('users').document(widget.uid).collection('stats').snapshots(),
                                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                        if(snapshot.data == null) return CircularProgressIndicator();
                                                        return new Text(snapshot.data.documents[0].data['entries'].toString(),
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                color: Theme.of(context).accentColor)
                                                        );
                                                      }
                                                    )
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
                                            CaptainScreen(uid: widget.uid)));
                              } //onPressed
                          )
                      ),
                    ]
                ),
              ),
            ],
          )),
    );
  }
}