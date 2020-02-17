import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
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
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Text('bottom sheet'),
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
          child: BrewList(),
        ),
      ),
      value: DatabaseService().brews,
    );
  }
}
