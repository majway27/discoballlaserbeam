import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class LogEntry extends StatelessWidget {
  LogEntry({@required this.date, this.entry});
  List <Color> _colors = [Color(0xFF0D1321), Colors.transparent];
  final date;
  final entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(DateFormat('yyyy-MM-dd')
              .format(DateTime.fromMillisecondsSinceEpoch(date))),
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
                                                      Text('Modify Entry',
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
                                                      Text(entry,
                                                          style: TextStyle(
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
                          )
                      ),
                    ]
                ),
              ),
            ],
          )
      ),
    );
  } //Widget
} // LogEntry