import 'dart:ui';

import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  60.0,
                  20.0,
                  60.0,
                  20.0 + MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SettingsForm(),
              ),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                textColor: Colors.white,
                onPressed: () async => await _auth.signOut(),
                icon: Icon(Icons.person),
                label: Text('Logout')),
            FlatButton.icon(
              onPressed: _showSettingsPanel,
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'settings',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/coffee_bg.png',
                  ))),
          child: BrewList(),
        ),
      ),
      value: DatabaseService().brews,
    );
  }
}
