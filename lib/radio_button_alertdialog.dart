import 'package:flutter/material.dart';

class RadioButtonAlertDialog extends StatefulWidget {
  @override
  RadioButtonAlertDialogState createState() {
    return new RadioButtonAlertDialogState();
  }
}

class RadioButtonAlertDialogState extends State<RadioButtonAlertDialog> {
  int _currentIndex = 1;

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('RadioButton'),
            content: RadioListTile(
              title: Text("Radio Text"),
              groupValue: _currentIndex,
              value: 1,
              onChanged: (val) {
                setState(() {
                  _currentIndex = val;
                });
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RadioButton in AlertDialog'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Show Alert Dialog'),
          color: Colors.red,
          onPressed: () => _displayDialog(context),
        ),
      ),
    );
  }
}