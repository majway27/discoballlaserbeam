import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/customCard.dart';
import '../common/sign_in.dart';


class CaptainScreen extends StatefulWidget {
  static const String routeName = "/captainslog";

  @override
  _MyCaptainState createState() {
    return _MyCaptainState();
  }
}

class _MyCaptainState extends State<CaptainScreen> {
  FirebaseUser currentUser;
  TextEditingController taskDescripInputController;
  Firestore db;
  WriteBatch batch;
  DocumentReference logRef, statRef;
  int now;

  @override
  initState() {
    taskDescripInputController = new TextEditingController();

    getCurrentUser().then((result) => {
      setState(() {
        this.currentUser = result;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Captain's Log"),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(currentUser.uid)
                  .collection('captainslog')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new CustomCard(
                          date: document['date'],
                          entry: document['entry'],
                        );
                      }).toList(),
                    );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Future <void> _runBatchWrite() async {
    now = DateTime.now().millisecondsSinceEpoch;
    db = Firestore.instance;
    batch = db.batch();
    logRef = db.collection("users").document(currentUser.uid).collection('captainslog').document();
    statRef = db.collection("users").document(currentUser.uid).collection('stats').document('captainslog');
    batch.setData(this.logRef, {"date": now, "entry": taskDescripInputController.text});
    batch.updateData(this.statRef, {"entries": FieldValue.increment(1)});
    batch.commit();
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Column(
          children: <Widget>[
            Text("Please fill all fields to create a new task"),
            Expanded(
              child: TextField(
                decoration: InputDecoration(labelText: 'Log Entry'),
                controller: taskDescripInputController,
              ),
            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                taskDescripInputController.clear();
                Navigator.pop(context);
              }),
          FlatButton(
              child: Text('Add'),
              onPressed: () async {
                if (taskDescripInputController.text.isNotEmpty) {
                  await _runBatchWrite();
                  Navigator.pop(context);
                  taskDescripInputController.clear();
                } // If
              } // onPressed
          )
        ],
      ),
    );
  }

}