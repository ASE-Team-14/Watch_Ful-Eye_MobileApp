import 'dart:async';
import 'package:amplify_core/amplify_core.dart';
import 'package:watchfull_eye/signup_screen.dart';

import 'amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watchfull_eye/auth.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:watchfull_eye/datadisplay.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:watchfull_eye/settings.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
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
      localizationsDelegates: [
        // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'EN'), // French
      ],
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
    Timer(const Duration(seconds: 5), () {
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
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Text("We take care of your loved ones",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 130.0),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                child: Text(
                  "W",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 80,
                      color: Colors.black),
                ),
              ),
              // child: Text("Watchful Eye",
              //     style: TextStyle(
              //       fontSize: 40,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black,
              //     )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 210.0),
              child: Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              )),
            ),
          ],
        ),
        // decoration: const BoxDecoration(
        //     image: DecorationImage(
        //         image: NetworkImage(
        //             "https://i.pinimg.com/originals/12/a8/83/12a8831512376ec5b258a4c58e3617c9.jpg"),
        //         fit: BoxFit.cover)),
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
                    // If the form is valid, display a Snackbar.
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

class AmplifyTODO extends StatefulWidget {
  bool _amplifyConfigured = false;
  @override
  _AmplifyTODOState createState() => _AmplifyTODOState();
}

class _AmplifyTODOState extends State<AmplifyTODO> {
  bool _amplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }
  // Amplify _amplifyInstance = Amplify();

  // Future<void> _configureAmplify() async {
  //   try {
  //     AmplifyAuthCognito auth = AmplifyAuthCognito();
  //     _amplifyInstance.addPlugin(
  //       authPlugins: [auth],
  //     );
  //     await _amplifyInstance.configure(amplifyconfig);

  //     setState(() => _amplifyConfigured = true);
  //   } catch (e) {
  //     print(e);
  //     setState(() => _amplifyConfigured = false);
  //   }
  //   setState(() => _amplifyConfigured = true);
  // }

  Future<void> _configureAmplify() async {
    await Amplify.addPlugins([AmplifyAuthCognito()]);
    await Amplify.configure(amplifyconfig);
    setState(() {
      _amplifyConfigured = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
