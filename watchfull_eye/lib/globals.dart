// import 'package:flutter/cupertino.dart';

// TextEditingController name = TextEditingController();
// TextEditingController number = TextEditingController();
// TextEditingController email = TextEditingController();

// final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:watchfull_eye/datadisplay.dart';
import 'package:watchfull_eye/signup_screen.dart';
import 'email_validator.dart';

String userId = "";
String userName = "";
String mobileNumber = "";

Future<void> insertUserDetails(String userIdcontroller,
    String userNameController, String mobileNumberController) async {
  print(userIdcontroller);
  const String apiUrl =
      'https://2m3gb5nrg7.execute-api.us-east-2.amazonaws.com/dev/insertuserdata';
  final response = await http.post(Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userIdcontroller,
        'user_name': userNameController,
        'mobile_number': mobileNumberController
      }));
  if (response.statusCode == 200) {
    print(response.body);
    print('User details inserted successfully.');
  } else {
    print('Error inserting user details: ${response.statusCode}');
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController userIdcontroller = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "UserId"),
                controller: userIdcontroller,
                validator: (value) {
                  print("value =" + value!);
                  if (value == null || value.isEmpty) {
                    return 'Please enter your userid';
                  } else {
                    print("USERID= " + value);
                    
                    userId = value;
                  }
                  return null;
                },
                onSaved: (value) {
                  userId = value!;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: "Username"),
                controller: userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  } else {
                    userName = value;
                  }
                  return null;
                },
                onSaved: (value) {
                  userName = value!;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(labelText: "Number"),
                controller: mobileNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your number';
                  } else {
                    mobileNumber = value;
                  }
                  return null;
                },
                onSaved: (value) {
                  mobileNumber = value!;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  child: Text("LOG IN"),
                  onPressed: () {
                    print(userId);
                    print(userName);
                    print(mobileNumber);
                    insertUserDetails(userId, userName, mobileNumber);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WatchData()));
                  }),
              // ElevatedButton(
              //   child: Text("Create New Account"),
              //   onPressed: () => _gotoSignUpScreen(context),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
