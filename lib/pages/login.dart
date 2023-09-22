import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/square_title.dart';

import '../componenets/mybutton.dart';
import '../componenets/text_field.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({required this.onTap, super.key});

  final Function() onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  void loginUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    var t = 0;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ShowError(e.code);
      t = 1;
    }
    // pop the loading circle
    if(t == 0)Navigator.pop(context);
  }

  void ShowError(String error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.error_outlined),
            iconColor: Colors.red[550],
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            alignment: Alignment.center,
            title: Text(
              error,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              //logo
              Icon(
                Icons.delivery_dining,
                size: 150,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(
                height: 40,
              ),
              //welcome back and all
              const Text(
                "Welcome back you've been missed",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              //username
              Text_Field(
                name: "Username Or email",
                controller: emailcontroller,
                obscureText: false,
              ),

              //password
              Text_Field(
                name: "Password",
                controller: passwordcontroller,
                obscureText: true,
              ),

              //forget password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot password ?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      )),
                  const SizedBox(
                    width: 50.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),

              //sign in button
              MyButton(
                onTap: loginUser,
                LorR: true,
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Divider(
                      thickness: 2,
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "or Continue With",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Expanded(
                        child: Divider(
                      thickness: 2,
                    ))
                  ],
                ),
              ),
              //register now
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  SqaureTile(
                      onTap: () => AuthServices().signInWithGoogle(),
                      Imagepath: 'lib/images/google.png'),
                  const SizedBox(
                    width: 20,
                  ),
                  SqaureTile(onTap: () {}, Imagepath: 'lib/images/apple.png'),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "new User ? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const Text(
                "By logging in, you agree to Food Delivery's Privacy and Terms of Use",
                style: TextStyle(fontSize: 10),
              ),
              Text(
                "Terms and Conditions",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
