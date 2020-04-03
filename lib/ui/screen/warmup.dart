import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'package:discoballlaserbeam/ui/screen/login.dart';
import '../common/sign_in.dart';


class WarmupScreen extends StatefulWidget {
  static const String routeName = "/warmup";

  @override
  _WarmupPageState createState() => _WarmupPageState();
}

class _WarmupPageState extends State<WarmupScreen> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
          if (currentUser == null) {
            Navigator.pushReplacementNamed(context, "/login"),
          } else {
            signInWithGoogle().whenComplete(() {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            })
          }})
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}