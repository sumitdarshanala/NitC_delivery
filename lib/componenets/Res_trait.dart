import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Res_Trait extends StatelessWidget{
  const Res_Trait({required this.icon,required this.title,super.key});
  final IconData icon;
  final String title;
@override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon,
        size: 17,
        color: Colors.white,
      ),
      const SizedBox(width: 6),
      Text(
          title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ]);
  }
}