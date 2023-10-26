import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/square_title.dart';
import 'package:getmyfooddelivery/services/auth_services.dart';

import '../Data/dummydata.dart';
import '../componenets/mybutton.dart';
import '../componenets/text_field.dart';
import '../services/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({required this.onTap, super.key});

  final Function() onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  File? _pickedImage;
  String? _imageurl;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }
  void pickedImage(File pickedimage) {
    _pickedImage = pickedimage;
  }

  void registerUser() async {
    //circular dialog
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (passwordcontroller.text == confirmpasswordcontroller.text &&
        _pickedImage != null) {
      try {
        Navigator.pop(context);
        final Credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${Credential.user!.email}')
            .child('${Credential.user!.uid}.jpg');
        await storageRef.putFile(_pickedImage!);
        final imageurl = await storageRef.getDownloadURL();
        final json = {
          'email': emailcontroller.text,
          'password': passwordcontroller.text,
          'image_url': imageurl,
          'cart':<Item>[],
          'order':[]
        };
        final docUser = await FirebaseFirestore.instance
            .collection('user_images')
            .doc(Credential.user!.uid);
        await docUser.set(json);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        ShowError(e.code);
      }
    } else if(passwordcontroller.text != confirmpasswordcontroller.text) {
      Navigator.pop(context);
      passwordcontroller.clear();
      confirmpasswordcontroller.clear();
      ShowError("password didn't Match");
    }else{
      Navigator.pop(context);
      ShowError("Add-Profile-Photo");
    }
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImagePick(onPickImage: pickedImage),
                //welcome back and all
                const Text(
                  "Let's create an account for you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text_Field(
                  name: "email",
                  controller: emailcontroller,
                  obscureText: false,
                ), //password
                Text_Field(
                  name: "Password",
                  controller: passwordcontroller,
                  obscureText: true,
                ),
                //username
                Text_Field(
                  name: "ConfirmPassword",
                  controller: confirmpasswordcontroller,
                  obscureText: true,
                ),
                //forget password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: widget.onTap,
                        child: Text(
                          "Already have an account ?",
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
                  onTap: registerUser,
                  LorR: false,
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
                        onTap: (){
                           AuthServices().signInWithGoogle();
                        },
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
                  height: 25,
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
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
