import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices{
  //signin with google
  signInWithGoogle()async{
    //begin interactive sign in process
    final GoogleSignInAccount?gUser = await GoogleSignIn().signIn();

    //obtain auth details free request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}