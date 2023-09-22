import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String link;
  const ImageDialog(this.link, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.network(
        link,
        width: 500,
        height: 500,
        fit: BoxFit.cover,
      ),
    );
  }
}