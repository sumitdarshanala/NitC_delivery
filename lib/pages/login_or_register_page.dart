import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/pages/login.dart';
import 'package:getmyfooddelivery/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget{
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showlogingpage = false;

  //toggles
  void togglesPages(){
    setState(() {
      showlogingpage = !showlogingpage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showlogingpage){
      return RegisterPage(onTap:togglesPages);
    }else {
      return LoginPage(onTap: togglesPages);
    }
  }
}