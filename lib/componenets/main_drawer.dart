import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/drawer_button.dart';
import 'package:getmyfooddelivery/componenets/logout_confirm.dart';
import 'package:getmyfooddelivery/pages/Edit_profile.dart';
import 'package:getmyfooddelivery/pages/orderPages.dart';
import 'package:getmyfooddelivery/pages/settingsPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_fade/image_fade.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Image_view.dart';
import 'getprofile.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({super.key, required this.selectedIndex});

  void Function(int index) selectedIndex;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getImageUrl();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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

  Object getAlert(BuildContext context){
    return  showDialog(
      context: context,
      builder:(_)=> AlertDialog(
        title: Text('Do you want to logout this account?'),
        content: Text('We hate to see you leave...'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              print("you choose no");
              Navigator.of(_).pop(false);
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(_);
              FirebaseAuth.instance.signOut();
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }




  String imageUrl = "";

  // 'https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/';


  @override
  Widget build(BuildContext context) {
    int i = 0;
    String email = user!.email.toString();
    int n = email.length;
    while (i < n) {
      if (email[i] == '@') {
        break;
      }
      i++;
    }
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onLongPress: () {
                    if (imageUrl.length != 0) {
                      showDialog(
                          context: context,
                          builder: (_) => ImageDialog(imageUrl));
                    } else {
                      Navigator.pop(context);
                      widget.selectedIndex(2);
                    }
                  },
                  child: imageUrl.length == 0
                      ? Container(
                          height: 200,
                          width: 100,
                          child: Center(
                              child: Icon(
                            Icons.account_circle,
                            size: 100,
                          )),
                        )
                      : Center(
                          child: Container(
                            height: 200,
                            width: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: imageUrl,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => EditProfile()),
                          );
                        },
                        hoverColor: Theme.of(context).colorScheme.primary,
                        trailing: Icon(Icons.edit),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary)),
                        tileColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        title: Text(
                          email.substring(0, 4),
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.primary),
                        )),
                    Text(
                      "    orders :${i}",
                      style: GoogleFonts.italianno(fontSize: 30),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          )),
          Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.edit,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  'Edit profile',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                      ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => EditProfile()),
                  );
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    'Orders',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => OrdersPage()),
                    );
                  }),
              ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    'Settings',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => SettingsPage()),
                    );
                  }),
              ListTile(
                leading: Icon(
                  Icons.share,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  'Share app',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 24,
                      ),
                ),
                onTap: () {},
              ),
              ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 24,
                        ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    getAlert(context);
                    // showDialog(
                    //     context: context, builder: (_) => ConfirmedLogout());
                  }),
              Container(
                height: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                          ))
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
