import 'package:flutter/cupertino.dart';

class SqaureTile extends StatelessWidget {
  const SqaureTile({required this.Imagepath,required this.onTap, super.key});
  final Function ()onTap;
  final String Imagepath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.white),
            borderRadius: BorderRadius.circular(25),
            color: CupertinoColors.white),
        child: Image.asset(
          Imagepath,
          height: 36,
        ),
      ),
    );
  }
}
