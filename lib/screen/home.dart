import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({required this.user, super.key});

  final user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
                child: Image(image: AssetImage('lib/assets/icon/deliver.png'))
            ),
            Center(
              child: Text("logged In as ${user.email}"),
            ),
            Container(
              height: 250,
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: Text("Food Delivery",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                ),
                Center(
                    child: Text(
                  "*All Rights are reserved*",
                  textScaleFactor: 0.6,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                )),
                SizedBox(
                  height: 30,
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
