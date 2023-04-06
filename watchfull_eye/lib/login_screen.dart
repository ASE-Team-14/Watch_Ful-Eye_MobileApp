// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:watchfull_eye/datadisplay.dart';
// import 'package:watchfull_eye/signup_screen.dart';

// import 'email_validator.dart';

// class LoginScreen extends StatelessWidget {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(50),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(labelText: "Email"),
//                 controller: _emailController,
//                 validator: (value) =>
//                     !validateEmail(value!) ? "Email is Invalid" : null,
//               ),
//               TextFormField(
//                 keyboardType: TextInputType.visiblePassword,
//                 decoration: InputDecoration(labelText: "Password"),
//                 obscureText: true,
//                 controller: _passwordController,
//                 validator: (value) =>
//                     value!.isEmpty ? "Password is invalid" : null,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ElevatedButton(
//                 child: Text("LOG IN"),
//                 onPressed: () => _loginButtonOnPressed(context),
//               ),
//               ElevatedButton(
//                 child: Text("Create New Account"),
//                 onPressed: () => _gotoSignUpScreen(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _loginButtonOnPressed(BuildContext context) async {
//     if (_formKey.currentState!.validate()) {
//       final email = _emailController.text;
//       final password = _passwordController.text;
//       //TODO: Login code
//       try {
//         final SignInResult =
//             await Amplify.Auth.signIn(username: email, password: password);
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => WatchData()));
//         if (SignInResult.isSignedIn) {}
//       } on AuthException catch (e) {
//         print(e);
//       }
//     }
//   }

//   void _gotoSignUpScreen(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => SignUpScreen(),
//       ),
//     );
//   }
// }
