import 'package:flutter/material.dart';
import 'package:discoballlaserbeam/ui/screen/login.dart';
import 'package:discoballlaserbeam/data/services/auth.dart';


class SettingsScreen extends StatelessWidget {
  static const String routeName = "/settings";
  List <Color> _colors = [Color(0xFF0D1321), Colors.transparent];
  SettingsScreen({Key key, this.auth, this.uid}) : super(key: key);
  final Auth auth;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
                                  color: Theme.of(context).accentColor,
                                  height: 200,
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
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              auth.imageUrl,
                                            ),
                                            radius: 40,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.all(10.0),
                                          child: Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Text('Name:  '),
                                                    Text(auth.name,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white)),
                                                  ],
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text('Email:  '),
                                                    Text(auth.email,
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
                                    height: 200,
                                  ),
                                ),
                              ],
                            ),
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
                margin: const EdgeInsets.fromLTRB(10,5,10,10),
                child: Row(
                    children: <Widget>[
                      Expanded(
                          child: FlatButton(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  color: Colors.grey[600],
                                  height: 100,
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: RaisedButton(
                                      onPressed: () {
                                        auth.signOutGoogle();
                                        Navigator.of(context).pushAndRemoveUntil(
                                            MaterialPageRoute(builder: (context) {
                                              return LoginScreen();
                                            }
                                         ), ModalRoute.withName('/'));
                                      },
                                      color: Theme.of(context).accentColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.lock_open,
                                            ),
                                            Text(
                                              '  Log Out',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ],
                                        )
                                      ),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ]
                ),
              )
            ],
        )
      )
    );
  }
}