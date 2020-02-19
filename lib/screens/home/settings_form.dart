import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/share/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/database_service.dart';
import '../../share/loading.dart';

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
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('update your brew settings.',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: _currentName ?? userData.name,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                    decoration: kTextInputDecoration,
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField(
                    decoration: kTextInputDecoration,
                    isDense: true,
                    value: _currentSugars ?? userData.sugars,
                    onChanged: (value) =>
                        setState(() => _currentSugars = value),
                    items: sugars
                        .map((sugar) => DropdownMenuItem(
                              value: sugar,
                              child: Text('$sugar sugars'),
                            ))
                        .toList(),
                  ),
                  Slider(
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    activeColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (double value) =>
                        setState(() => _currentStrength = value.round()),
                    value: (_currentStrength ?? userData.strength).toDouble(),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
