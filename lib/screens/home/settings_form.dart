import 'package:brew_crew/share/constants.dart';
import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text('update your brew settings.', style: TextStyle(fontSize: 18.0)),
          SizedBox(height: 20.0),
          TextFormField(
            initialValue: _currentName,
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _currentName = val),
            decoration: kTextInputDecoration,
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField(
            decoration: kTextInputDecoration,
            isDense: true,
            value: _currentSugars,
            onChanged: (value) => setState(() => _currentSugars = value),
            items: sugars
                .map((sugar) => DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    ))
                .toList(),
          ),
          Slider(
            min: 100,
            max: 900,
            divisions: 8,
            onChanged: (double value) =>
                setState(() => _currentStrength = value.round()),
            value: _currentStrength.toDouble(),
          ),
          RaisedButton(
            onPressed: () {},
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
