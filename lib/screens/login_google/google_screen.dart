import 'package:course_app/layout/home.dart';
import 'package:course_app/shared/componentes/components.dart';
import 'package:course_app/shared/network/local/shared_prefrence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleScreen extends StatelessWidget {
  var firstNameController = TextEditingController();

  var lastNameController = TextEditingController();

  var emailController = TextEditingController();

  var passController = TextEditingController();

  var cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes:
  [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

Future<void> handleSignIn(ctx) async {
  await googleSignIn.signIn().then((value) async
  {
    print(value.email);
    print(value.displayName);
    print(value.photoUrl);


    GoogleSignInAuthentication googleSignInAuthentication = await value.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      print(value.user.uid);
      //print('token-------${googleSignInAuthentication.accessToken}');
      saveToken(googleSignInAuthentication.accessToken).then((value)
      {
        if(value){
          showToast(text:'success save token', error: false);
          navigateAndFinish(ctx ,HomeScreen());
        }
        else{
          showToast(text:'Error while saving a token', error: false);
        }
      });
      // navigateAndFinish(ctx, HomeScreen(saveToken()));
    }).catchError((e)
    {
      print(e.toString());
    });

  }).catchError((e){
    print(e.toString());
  });
}
