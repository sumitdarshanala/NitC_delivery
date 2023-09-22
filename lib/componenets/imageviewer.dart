import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage extends StatefulWidget {
  ViewImage({required this.getimage,required this.tag, required this.imageurl, super.key});

  final imageurl;
  final tag;
  void Function () getimage;

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Profile Photo',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
                widget.getimage();
              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            child: Hero(
              transitionOnUserGestures: true,
              tag: widget.tag,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: PhotoView(
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 0.5,
                  imageProvider: NetworkImage(widget.imageurl),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
