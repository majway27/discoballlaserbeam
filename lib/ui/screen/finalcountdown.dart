
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';


class CountdownScreen extends StatefulWidget {
  static const String routeName = "/finalcountdown";

  @override
  _MyCountdownState createState() {
    return _MyCountdownState();
  }

}

class _MyCountdownState extends State<CountdownScreen> {

  Timer _timer;
  int _timer_target = 3600;
  int _runTime = 0;
  List<String> _todoItems = [];
  bool _canVibrate;

  // This will be called each time the + button is pressed
  void _addTodoItem() {
    //_canVibrate = await Vibration.hasVibrator();
    _canVibrate = true;
    TimeOfDay now = TimeOfDay.now();
    setState(() => _todoItems.add(now.toString()));
    if (_canVibrate) {
      Vibration.vibrate(duration: 1000);
      Vibration.vibrate(duration: 3000);
      Vibration.vibrate(duration: 1000);
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
        title: new Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
    );
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  void cancelTimer() {
    _timer.cancel();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _runTime = _timer_target;
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_runTime < 1) {
            _addTodoItem();
            _runTime = _timer_target;
          } else {
            _runTime = _runTime - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Final Countdown!")),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              startTimer();
            },
            child: Text("Start"),
          ),
          RaisedButton(
            onPressed: () {
              cancelTimer();
            },
            child: Text("Cancel"),
          ),
          Text("$_runTime"),
          _buildTodoList()
        ],
      ),
    );
  }
}
