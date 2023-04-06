import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter/material.dart';
import 'package:watchfull_eye/dashboard.dart';
import 'package:watchfull_eye/datadisplay.dart';
import 'package:watchfull_eye/globals.dart';
import 'package:watchfull_eye/manageuserlist.dart';
import 'package:watchfull_eye/testingaws.dart';

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

void addUsers() {
  manageUserName.add(name);
}

void addmail() {
  manageUserEmail.add(userName);
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
        backgroundColor: Colors.cyan,
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
                decoration: const InputDecoration(
                  labelText: 'UserName',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  } else {
                    userName = value;
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
                  labelText: 'UserId',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your UserId';
                  } else {
                    userId = value;
                    addmail();
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else {
                    mobileNumber = value;
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
                      insertUserDetails(userId, userName, mobileNumber);
                      SnackBar(content: Text("User Added"));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserListScreen()));
                },
                child: Text('View Users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
