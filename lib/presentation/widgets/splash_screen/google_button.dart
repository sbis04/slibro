// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:slibro/application/res/palette.dart';
// import 'package:slibro/infrastructure/authentication.dart';
// import 'package:slibro/presentation/screens/welcome_screen.dart';

// class GoogleButton extends StatefulWidget {
//   @override
//   _GoogleButtonState createState() => _GoogleButtonState();
// }

// class _GoogleButtonState extends State<GoogleButton> {
//   bool _isSigningIn = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: _isSigningIn
//           ? CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(
//                 Palette.black,
//               ),
//             )
//           : OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 side: BorderSide(
//                   color: Palette.black,
//                   width: 1,
//                 ),
//               ),
//               onPressed: () async {
//                 setState(() {
//                   _isSigningIn = true;
//                 });

//                 User? user = await Authentication.signInWithGoogle();

//                 setState(() {
//                   _isSigningIn = false;
//                 });

//                 if (user != null) {
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(
//                       builder: (context) => WelcomeScreen(
//                         user: user,
//                       ),
//                     ),
//                   );
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image(
//                       image: AssetImage("assets/google_logo.png"),
//                       height: 35.0,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10),
//                       child: Text(
//                         'Sign in with Google',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black54,
//                           fontFamily: '',
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
