import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  const ImagePick({super.key, required this.onPickImage});

  final Function(File pickedImage) onPickImage;

  @override
  State<ImagePick> createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
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
      Navigator.pop(context);
    });
    widget.onPickImage(_pickedImageFile!);
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
                              .primaryContainer, // splash color
                          onTap: () {
                            selectImage(true);
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
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
                              .primaryContainer, // splash color
                          onTap: () {
                            selectImage(false);
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.photo_album,
                                size: 50,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary,
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

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          radius: 80,
          child: CircleAvatar(
            radius: 75,
            foregroundImage:
                _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
            child: _pickedImageFile == null
                ? Icon(Icons.person,
                    color: Theme.of(context).colorScheme.primary, size: 100)
                : null,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: IconButton(
            onPressed: getImage,
            icon: Icon(
              Icons.add_a_photo,
              color: Theme.of(context).colorScheme.primaryContainer,
              size: 25,
            )),
      ),
    ]);
  }
}
