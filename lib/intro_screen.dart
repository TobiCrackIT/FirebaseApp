import 'package:firebaseapp/main.dart';
import 'package:firebaseapp/sign_up_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {



  @override
  void initState() {
    super.initState();

    /*FirebaseAuth.instance.currentUser().then((value){
      print(value);

      if(value != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
      }
    });*/

  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        title: new Text('Welcome the most awe-some\nNewz App!',
          style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
          textAlign: TextAlign.center,
        ),
        image: Image.asset('assets/images/monica.png',fit:BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("flutter"),
        loaderColor: Colors.greenAccent,
        loadingText: Text('Preparing the best experience for you',
          style: new TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 11.0
          ),
          textAlign: TextAlign.center,
        ),
        navigateAfterSeconds: SignUpOptionsScreen(),
    );
  }
}
