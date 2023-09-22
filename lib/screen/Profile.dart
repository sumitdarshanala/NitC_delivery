import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

import '../componenets/imageviewer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    getImageUrl();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;

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

  void selectImage(bool check) async {
    showDialog(
        context: context,
        builder: (context) {
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
    setState(() {
      _pickedImageFile = File(pickedImage.path);
      registerUser();
      Navigator.pop(context);
    });
    // widget.onPickImage(_pickedImageFile!);
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
                              Text("Gallery"), // text
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
            password = data['password'];
          }
        });
        final json = <String, String>{
          "email": user!.email.toString(),
          "image_url": _imageurl,
          "password": password,
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
    return SafeArea(
        child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: (imageUrl.length != 0)
                  ? GestureDetector(
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
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    blurRadius: 8,
                                    spreadRadius: 6,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                                border: Border.all(color: Colors.blueAccent),
                                shape: BoxShape.circle),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: imageUrl,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.account_circle,
                      size: 200,
                    ),
            ),
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
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text(user!.email.toString()),
          trailing: Icon(Icons.edit),
        ),
        ListTile(
          leading: Icon(Icons.error_outline),
          title: Text(" about "),
          trailing: Icon(Icons.edit),
        ),
      ],
    ));
  }
}
