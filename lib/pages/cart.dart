import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/shop_wid.dart';

class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool check = false;
  final user = FirebaseAuth.instance.currentUser;

  List<dynamic> item_in_cart = [];

  @override
  void initState() {
    getCart();
    super.initState();
  }

  double cost = 0.0;
  double size = 0;
  Future<void> getCart() async {
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        final data = value.data() as Map<String, dynamic>;
        if (data['cart'] != null) {
          setState(() {
            item_in_cart = data['cart'];
          });
        }
      }
    });
    for (final item in item_in_cart) {
      cost += item['price'] * item['num'];
      size += item['num'];
    }
    check = true;
    print(cost);
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget main = check
        ? (item_in_cart.length != 0)
            ? Column(
                children: [for (final item in item_in_cart) Shop(map: item)],
              )
            : Center(
                child: Text(
                  'Empty Cart !!!',
                  style: TextStyle(fontSize: 20),
                ),
              )
        : Center(child: CircularProgressIndicator());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int n = size.toString().length;
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          height: 50,
          width: 100,
          child: FloatingActionButton(
            onPressed: () {},
            child: Text(
              "CheckOut",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "Cart",
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * (2 / 3),
              child: SingleChildScrollView(child: main),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  const Expanded(
                      child: Divider(
                    thickness: 2,
                  )),
                  SizedBox(height: 10)
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 3,
                ),
                Text(
                  "  Total Cost :",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: width / 5,
                ),
                Text("$cost"),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: width / 3,
                ),
                Text(
                  "  Number of Items :",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  width: width / 5,
                ),
                Text((size).toString().substring(0,n-2)),
              ],
            ),
          ],
        ));
  }
}
