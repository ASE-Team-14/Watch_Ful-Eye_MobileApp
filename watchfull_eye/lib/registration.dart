// import 'package:flutter/material.dart';
// // import 'package:amazon_cognito_identity_dart_2/cognito.dart';
// import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
// import 'package:amazon_cognito_identity_dart_2/cognito.dart';

// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();

//   bool _isLoading = false;

//   void _register() async {
//     setState(() {
//       _isLoading = true;
//     });

//     // Create a new Cognito user pool instance
//     final userPool = new CognitoUserPool(
//       'us-east-1_XXXXXXXXX', // Replace with your user pool ID
//       'XXXXXXXXXXXXXXXXXXXXXXXXXX', // Replace with your app client ID
//     );

//     // Create a new user attributes object
//     final attributes = [
//       new AttributeArg(name: 'name', value: _nameController.text),
//     ];

//     // Create a new Cognito user object
//     final user = await userPool.signUp(
//       _emailController.text.trim(),
//       _passwordController.text,
//       userAttributes: attributes,
//     );

//     // Send verification email
//     await userPool.client.sendEmailVerificationCode(_emailController.text);

//     setState(() {
//       _isLoading = false;
//     });

//     // Navigate to verification page
//     Navigator.pushNamed(context, '/verification', arguments: {
//       'userPool': userPool,
//       'email': _emailController.text,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!value.contains('@')) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       child: Text('Register'),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _register();
//                         }
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
