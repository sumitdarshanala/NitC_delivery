import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  Home({required this.user, super.key});

  final user;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(
            'lib/images/wave.svg',width: double.infinity,
          )),
    ]);
  }
}
