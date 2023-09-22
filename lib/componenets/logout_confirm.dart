import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmedLogout extends StatelessWidget {
  const ConfirmedLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Dialog(
      child: Container(
        height: 250,
        width: 150,
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Logout ?",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Are you Sure you want to log out of your Account ?",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w100),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80)),
                          child: Center(child: Text("Log out")),
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Card(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryContainer
                              .withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80)),
                          child: Center(child: Text("Cancel")),
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
