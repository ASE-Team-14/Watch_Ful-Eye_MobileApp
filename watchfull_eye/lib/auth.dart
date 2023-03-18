// // import 'package:flutter/material.dart';
// // import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// // // Create a new instance of the user pool object
// // final userPool = new CognitoUserPool(
// //   'us-east-2_sM5PCs46z',
// //   '7o5vo6taa33mpi1uumg7d2tnnr',
// // );

// // class RegistrationPage extends StatefulWidget {
// //   @override
// //   _RegistrationPageState createState() => _RegistrationPageState();
// // }

// // class _RegistrationPageState extends State<RegistrationPage> {
// //   final emailController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final usernameController = TextEditingController();
// //   final numberController = TextEditingController();

// //   void registerUser() async {
// //     final email = emailController.text;
// //     final password = passwordController.text;
// //     final username = usernameController.text;
// //     final number = numberController.text;

// //     final userAttributes = [
// //       new AttributeArg(
// //         name: 'email',
// //         value: email,
// //       ),
// //       new AttributeArg(name: 'number', value: number),
// //       new AttributeArg(name: 'username', value: username),
// //     ];

// //     try {
// //       final result = await userPool.signUp(email, password, username, number,
// //           userAttributes: userAttributes);
// //       print('User registration successful: $result');
// //     } on CognitoClientException catch (e) {
// //       print('User registration failed: ${e.message}');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Registration Page'),
// //       ),
// //       body: Container(
// //         padding: EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextFormField(
// //               controller: emailController,
// //               decoration: InputDecoration(
// //                 hintText: 'Email',
// //               ),
// //             ),
// //             TextFormField(
// //               controller: passwordController,
// //               decoration: InputDecoration(
// //                 hintText: 'Password',
// //               ),
// //             ),
// //             TextFormField(
// //               controller: usernameController,
// //               decoration: InputDecoration(
// //                 hintText: 'Username',
// //               ),
// //             ),
// //             TextFormField(
// //               controller: numberController,
// //               decoration: InputDecoration(
// //                 hintText: 'Phone Number',
// //               ),
// //             ),
// //             ElevatedButton(
// //               onPressed: registerUser,
// //               child: Text('Register'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:amazon_cognito_identity_dart_2/cognito.dart';
// import 'package:flutter/material.dart';

// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _usernameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text('Registration Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(labelText: 'Username'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a username';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your email address';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: InputDecoration(labelText: 'Phone Number'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 TextFormField(
//                   controller: _passwordController,
//                   decoration: InputDecoration(labelText: 'Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter a password';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       try {
//                         CognitoUserPool pool = new CognitoUserPool(
//                           'us-east-2_sM5PCs46z',
//                           '7o5vo6taa33mpi1uumg7d2tnnr',
//                         );
//                         CognitoUserPoolData result = await pool.signUp(
//                           _usernameController.text,
//                           _passwordController.text,
//                           _phoneController.text,
//                           _emailController.text,
//                           userAttributes: [
//                             new AttributeArg(
//                                 name: 'name', value: _nameController.text),
//                             new AttributeArg(
//                                 name: 'email', value: _emailController.text),
//                             new AttributeArg(
//                                 name: 'phone_number',
//                                 value: _phoneController.text),
//                           ],
//                         );
//                         print(result);
//                         // _scaffoldKey.currentState.showSnackBar(
//                         //   SnackBar(
//                         //     content: Text('Registration successful'),
//                         //   ),
//                         // );
//                         Navigator.pop(context);
//                       } catch (e) {
//                         print(e);
//                         // _scaffoldKey.currentState.showSnackBar(
//                         //   SnackBar(
//                         //     content: Text('Registration failed: $e'),
//                         //   ),
//                         // );
//                       }
//                     }
//                   },
//                   child: Text('Register'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
