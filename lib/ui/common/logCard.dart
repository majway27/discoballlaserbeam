import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'logEntry.dart';

class LogCard extends StatelessWidget {
  LogCard({@required this.date, this.entry});
  List <Color> _colors = [Color(0xFF0D1321), Colors.transparent];

  final date;
  final entry;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[600]),
            borderRadius: BorderRadius.circular(5.0),
            gradient: LinearGradient(
              colors: _colors,
              begin:  Alignment.topLeft,
              end:  Alignment.bottomRight,
            )
          ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Theme.of(context).accentColor,
                          height: 100,
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
                                Text(DateFormat('yyyy-MM-dd')
                                    .format(DateTime.fromMillisecondsSinceEpoch(date))),
                                Text(entry),
                              ], //Children
                            ),
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LogEntry(
                                      date: date, entry: entry)));
                    } //onPressed
                )
                ),
              ]
            ),
        )
    );
  } // Widget
} //Class