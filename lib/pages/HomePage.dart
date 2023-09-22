import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/main_drawer.dart';
import 'package:getmyfooddelivery/pages/Edit_profile.dart';
import 'package:getmyfooddelivery/pages/cart.dart';
import 'package:getmyfooddelivery/pages/notification.dart';

import '../screen/Profile.dart';
import '../screen/home.dart';
import '../screen/request_list_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final user = FirebaseAuth.instance.currentUser;

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getImageUrl() async {
    var image;
    await FirebaseFirestore.instance
        .collection('user_images')
        .doc(user!.uid)
        .get()
        .then((value) {
      final data = value.data() as Map<String, dynamic>;
      image = data['image_url'];
    });
    setState(() {
      imageUrl = image;
    });
  }

  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Delivery",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => Notifications()),
                  ),
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => Cart()),
                  ),
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      drawer: MainDrawer(
        selectedIndex: changeIndex,
      ),
      body: _selectedIndex == 0
          ? Home(user: user)
          : _selectedIndex == 1
              ? RequestList()
              : Profile(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
