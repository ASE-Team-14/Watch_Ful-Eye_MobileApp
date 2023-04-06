import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:watchfull_eye/datadisplay.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  runApp(const MyApp());
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(const Duration(seconds: 4), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WatchData()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/Images/watchful-eye-logo (1).png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class UserRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'User Registration';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your full name',
              labelText: 'Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.mail_outline_sharp),
              hintText: 'Mail Address',
              labelText: 'Email',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid mail id';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lock_outline_sharp),
              hintText: 'Password',
              labelText: 'Password ',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter valid Password';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.lock_outline_sharp),
              hintText: 'Confirm Password',
              labelText: 'Confirm Password ',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please reenter Password';
              }
              return null;
            },
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 20.0),
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () {
                  // It returns true if the form is valid, otherwise returns false
                  if (_formKey.currentState!.validate()) {
                    //                 final snackBar = SnackBar(content: Text('Hello, world!'));
                    // _scaffoldKey.currentState!.showSnackBar(snackBar);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WatchData()));
                  }
                },
              )),
        ],
      ),
    );
  }
}

