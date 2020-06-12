import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/custom_drawer.dart';
import 'package:firebaseapp/intro_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  final FirebaseUser firebaseUser;
  HomeScreen({Key key,@required this.firebaseUser}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              firebaseAuth.signOut().then((res) {
                print('User signed out...');
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => IntroScreen()),
                );
              });
            },
          )
        ],
      ),
      drawer: CustomDrawer(userID: firebaseUser.uid),
      body: Center(
        child: Text('Welcome ${firebaseUser.email}'),
      ),
    );
  }
}
