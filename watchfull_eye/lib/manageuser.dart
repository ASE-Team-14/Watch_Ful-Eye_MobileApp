import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:watchfull_eye/dashboard.dart';

final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _numberController = TextEditingController();
String name = "";
String email = "";
List<String> manageUserName = [];
List<String> manageUserEmail = [];

// Future<String> signUpUser(String email, String password) async {
//   final userPool = new CognitoUserPool(
//     // Replace these values with your own User Pool configuration
//     'us-east-2_sM5PCs46z', // User Pool ID
//     '7o5vo6taa33mpi1uumg7d2tnnr', // App client ID
//   );

//   final newUserAttributes = [
//     new AttributeArg(name: 'email', value: email),
//   ];

//   final signUpResponse =
//       await userPool.signUp(email, password, userAttributes: newUserAttributes);

//   return signUpResponse.userConfirmed.toString();
// }

void addUsers() {
  manageUserName.add(name);
}

void addmail() {
  manageUserEmail.add(email);
}

void clearUsers() {
  _nameController.dispose();
  _emailController.dispose();
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else {
                    name = value;
                    addUsers();
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else {
                    email = value;
                    addmail();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayField()));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
