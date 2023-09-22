import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Text_Field extends StatelessWidget{
  const Text_Field({required this.name,required this.controller,required this.obscureText,super.key});
  final String name;
  final controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0,8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: name,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary)),
            fillColor: Theme.of(context).colorScheme.secondaryContainer,
            filled: true),
      ),
    );
  }
}