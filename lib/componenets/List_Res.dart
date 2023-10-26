import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Data/dummydata.dart';
import '../pages/Restaurant.dart';
import 'Res_trait.dart';

class Res extends StatelessWidget{
  const Res({required this.id,required this.name,required this.url,required this.distance,required this.type,required this.menu,super.key});
  final String id;
  final String name;
  final String url;
  final int distance;
  final String type;
  final List<Item> menu;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => RestaurantDetails(id: id,name: name,url: url,menu: menu,)),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(url),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Res_Trait(icon: Icons.schedule,title: " ${distance*35} min",),
                        const SizedBox(width: 20),
                        Res_Trait(icon: Icons.work,title: "${distance} km",),
                        const SizedBox(width: 20),
                        Res_Trait(icon: Icons.attach_money,title:type)
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}