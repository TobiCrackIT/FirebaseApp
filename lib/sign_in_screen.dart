import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/home_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
  FirebaseDatabase.instance.reference().child("Users");

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Text("Sign In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          fontFamily: 'Roboto')),
                  Text("with e-mail",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          fontFamily: 'Roboto')),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Enter E-mail',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'E-mail address cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          labelText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Visibility(
                    visible: !isLoading,
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: Colors.greenAccent,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          registerToFirebase();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: Container(
                      height: 36,
                      width: 36,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green),
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void registerToFirebase() async {
    setState(() {
      isLoading = true;
    });

    login();
  }


  void login() {
    firebaseAuth
        .signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((result) {

          setState(() {
            isLoading = false;
          });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(firebaseUser: result.user)),
      );
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passwordController.clear();
  }
}
