import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/pages/login.dart';
import 'package:getmyfooddelivery/pages/login_or_register_page.dart';

import 'HomePage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  void checkStatus() async{
    bool isNetwork = await hasNetwork();
    if(isNetwork){
      //network issue is to be solve here

    }
  }
  @override
  Widget build(BuildContext context)  {
    checkStatus();
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if(snapshot.hasData){
            return HomePage();
          }else{
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
