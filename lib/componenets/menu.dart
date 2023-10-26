import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Data/dummydata.dart';
import 'item_wid.dart';

class Menu extends StatelessWidget {
  const Menu({required this.inc,required this.dec,required this.menu,required this.list, super.key});

  final List<Item> menu;
  final List list;
  final void Function(int i) inc;
  final  void Function(int i) dec;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final item in menu)
            item_wid(item:item,count:list,inc:inc,dec:dec),
        ],
      ),
    );
  }
}
