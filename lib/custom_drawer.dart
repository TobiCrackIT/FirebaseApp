import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {

  final String userID;
  const CustomDrawer({Key key,@required this.userID}):super(key:key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getUserDetails(),
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text('${snapshot.data.email}'),
                    accountName: Text('${widget.userID.toString()}'),
                    decoration: BoxDecoration(
                      color: Colors.green,
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

          return Container(
            height: 50,
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 2.0,
                ),
              ),
            ),
          );
        }
    );
  }

  getUserDetails() async{
    //var user=await dbRef.once();
    var user=firebaseAuth.currentUser();
        //.equalTo(widget.userID);
    return user;
  }
}
