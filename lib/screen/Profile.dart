import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

import '../componenets/imageviewer.dart';
import '../pages/Edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getImageUrl();
    getAbout();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

  void getAbout() async {
    final _about = await FirebaseFirestore.instance
        .collection('user_images')
        .doc(user!.uid)
        .get()
        .then((value) {
      final data = value.data() as Map<String, dynamic>;
      return data['about'];
    });
    if (_about != null) {
      setState(() {
        about = _about;
      });
    }
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
  File? _pickedImageFile;
  String about = "Available";

  void selectImage(bool check) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    final pickedImage;
    if (check) {
      pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
    } else {
      pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
    }
    if (pickedImage == null) {
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context);
    setState(() {
      _pickedImageFile = File(pickedImage.path);
      registerUser();
    });
  }

  void getImage() {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: 200,
            child: Column(children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox.fromSize(
                      size: Size(100, 100), // button width and height
                      child: Material(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer, // button color
                        child: InkWell(
                          splashColor: Theme.of(context)
                              .colorScheme
                              .primary, // splash color
                          onTap: () {
                            selectImage(true);
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_a_photo,
                                size: 50,
                              ), // icon
                              Text("Camera"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(100, 100), // button width and height
                      child: Material(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer, // button color
                        child: InkWell(
                          splashColor: Theme.of(context)
                              .colorScheme
                              .primary, // splash color
                          onTap: () {
                            selectImage(false);
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.photo_album,
                                size: 50,
                              ), // icon
                              Text("Gallery"), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ]),
          );
        });
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

    if (_pickedImageFile != null) {
      try {
        Navigator.pop(context);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${user!.email}')
            .child('${user!.uid}.jpg');
        await storageRef.putFile(_pickedImageFile!);
        final _imageurl = await storageRef.getDownloadURL();
        print(_imageurl);
        var password = "sumit123";

        await FirebaseFirestore.instance
            .collection('user_images')
            .doc(user!.uid)
            .get()
            .then((value) {
          if (value.data() != null) {
            final data = value.data() as Map<String, dynamic>;
            if(data['password'] != null) {
              password = data['password'];
            }
          }
        });
        var order = [];
        var cart = [];
        await FirebaseFirestore.instance
            .collection('user_images')
            .doc(user!.uid)
            .get()
            .then((value) {
          if (value.data() != null) {
            final data = value.data() as Map<String, dynamic>;
            if(data['cart'] != null) {
              cart = data['cart'];
            }
          }
        });
        await FirebaseFirestore.instance
            .collection('user_images')
            .doc(user!.uid)
            .get()
            .then((value) {
          if (value.data() != null) {
            final data = value.data() as Map<String, dynamic>;
            if(data['order'] != null) {
              order = data['order'];
            }
          }
        });
        final json = <String, dynamic>{
          "email" : user!.email.toString(),
          "image_url" : _imageurl,
          "password" : password,
          "cart" : cart,
          "order" : order,
        };
        setState(() {
          imageUrl = _imageurl;
        });
        final docUser = await FirebaseFirestore.instance
            .collection('user_images')
            .doc(user!.uid)
            .set(json);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => ViewImage(
                                  tag: 'profile',
                                  imageurl: imageUrl,
                                  getimage: getImage)),
                        ),
                    child: Center(
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: 'profile',
                        child: Container(
                          height: 175,
                          width: 175,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 0),
                              ),
                            ],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: (imageUrl.length != 0)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: imageUrl,
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.account_circle,
                                  size: 175,
                                ),
                        ),
                      ),
                    ))),
            IconButton(
              onPressed: getImage,
              icon: Icon(
                Icons.add_a_photo,
                size: 25,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => EditProfile()),
              );
            },
            leading: Icon(Icons.account_circle),
            subtitle: Text(
              user!.email.toString(),
              textScaleFactor: 1.25,
            ),
            title: Text(
              "Email",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.edit),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => EditProfile()),
              );
            },
            leading: Icon(Icons.error_outline),
            title: Text(
              "About",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(about),
            trailing: Icon(Icons.edit),
          ),
        ),
        Container(
          height: 100,
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
