import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        builder: (BuildContext context,AsyncSnapshot<FirebaseUser> snapshot){
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(snapshot.toString()),
                  accountName: Text(snapshot.toString()),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),

                ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.home, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Home'),
                  onTap: () {
                    print('Home!');
                  },
                ),
                ListTile(
                  leading: new IconButton(
                    icon: new Icon(Icons.settings, color: Colors.black),
                    onPressed: () => null,
                  ),
                  title: Text('Settings'),
                  onTap: () {
                    print('Settings!');
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  Future<FirebaseUser> getImages() {
    //return fb.collection("images").getDocuments();
  }
}
