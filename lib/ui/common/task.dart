import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  TaskPage({@required this.date, this.entry});

  final date;
  final entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(DateFormat('yyyy-MM-dd')
              .format(DateTime.fromMillisecondsSinceEpoch(date))),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(entry),
                RaisedButton(
                    child: Text('Back To HomeScreen'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () => Navigator.pop(context)),
              ]),
        ));
  }
}