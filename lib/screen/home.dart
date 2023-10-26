import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getmyfooddelivery/Data/dummydata.dart';
import 'package:getmyfooddelivery/componenets/List_Res.dart';
import 'package:getmyfooddelivery/pages/Restaurant.dart';
import 'package:transparent_image/transparent_image.dart';

import '../componenets/Res_trait.dart';

class Home extends StatelessWidget {
  Home({required this.user, super.key});

  final user;
  final data = dummyRestaurant;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for(final details in data)
              Res(id:details.id,name: details.title,url: details.url,distance: details.distance,type: details.type,menu: details.menu,),
        ],
      ),
    );
  }
}
