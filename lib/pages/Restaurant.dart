import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Data/dummydata.dart';
import '../componenets/menu.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails(
      {required this.id,
      required this.url,
      required this.name,
      required this.menu,
      super.key});

  final String id;
  final String name;
  final String url;
  final List<Item> menu;

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  void increment(int i) {
    if (count![i] >= 10) return;
    setState(() {
      count![i]++;
    });
  }

  void decrement(int i) {
    if (count![i] == 0) return;
    setState(() {
      count![i]--;
    });
  }

  final user = FirebaseAuth.instance.currentUser;

  void _addtoCart() async {
    int n = widget.menu.length;
    List<Map> cart = <Map>[];
    var password = 'sumit123';
    var order = [];
    bool check = false;
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc('${user!.uid}')
        .get()
        .then((value) {
      if (value.data() != null) {
        final data = value.data() as Map<String, dynamic>;
        if (data['password'] != null) {
          password = data['password'];
        }
      }
    });
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc('${user!.uid}')
        .get()
        .then((value) {
      if (value.data() != null) {
        final data = value.data() as Map<String, dynamic>;
        if (data['order'] != null) {
          order = data['order'];
        }
      }
    });
    var image_url = "";
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc('${user!.uid}')
        .get()
        .then((value) {
      if (value.data() != null) {
        final data = value.data() as Map<String, dynamic>;
        if (data['image_url'] != null) {
          image_url = data['image_url'];
        }
      }
    });
    for (int i = 0; i < n; i++) {
      if (count![i] != 0) {
        check = true;
        Map<String, dynamic> map = {
          "num": count![i],
          "imageurl": widget.menu[i].imageurl,
          "name": widget.menu[i].name,
          "price": widget.menu[i].price
        };
        cart.add(map);
      }
    }
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc(user!.uid)
        .set(<String, dynamic>{
      "email": user!.email.toString(),
      "image_url": image_url,
      "password": password,
      "cart": cart,
      "order": order,
    });

    final snackBar = SnackBar(
      content: Center(child: check ? const Text('Yay!!, Items Added to Cart'):const Text('Try selecting some Item')),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return;
  }

  List? count;

  void init(List list) {
    count = list;
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.menu.length;
    List<int> count_1 = List.filled(length, 0, growable: false);
    if (count == null) {
      init(count_1);
    }
    print("hello sumit");
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _addtoCart,
          child: Icon(
            Icons.add,
          ),
          tooltip: 'Add to Cart',
        ),
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: widget.id,
                child: Image.network(
                  widget.url,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Available Items ',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              Menu(
                  menu: widget.menu,
                  list: count!,
                  inc: increment,
                  dec: decrement),
            ],
          ),
        ));
  }
}
