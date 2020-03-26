import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'task.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.date, this.entry});

  final date;
  final entry;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
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
                      /** Push a new page while passing data to it */
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TaskPage(
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