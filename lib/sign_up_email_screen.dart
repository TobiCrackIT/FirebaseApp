import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseapp/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpEmailScreen extends StatefulWidget {
  @override
  _SignUpEmailScreenState createState() => _SignUpEmailScreenState();
}

class _SignUpEmailScreenState extends State<SignUpEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child("Users");

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
                  Text("Sign Up",
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
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Enter Username',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
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
                      controller: ageController,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                          labelText: 'Enter Age',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Age cannot be empty';
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
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 2.0,
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

    /*var result = await signUpWithEmail(
        email: emailController.text, password: passwordController.text);

    setState(() {
      isLoading=false;
    });

    if(result??false){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }*/

    firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((value) {
      dbRef.child(value.user.uid).set({
        "email": emailController.text,
        "age": ageController.text,
        "name": nameController.text,
      }).then((result) {
        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    firebaseUser: value.user,
                  )),
        );
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(error.message),
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

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      dbRef.set({
        "email": emailController.text,
        "age": ageController.text,
        "name": nameController.text
      });

      return authResult.user != null;
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(e.message),
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
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    ageController.clear();
  }
}
