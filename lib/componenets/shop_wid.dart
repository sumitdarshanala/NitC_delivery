import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Image_view.dart';

class Shop extends StatelessWidget {
  Shop({required this.map, super.key});

  final Map<String, dynamic> map;

  @override
  Widget build(BuildContext context) {
    print(map.toString());
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        ListTile(
            leading: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => ImageDialog(map['imageurl']));
              },
              child: Container(
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: map['imageurl'],
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(map['name']),
            tileColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.black),
            ),
            subtitle: Text(" \$ ${map['price']}"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              Text('x',style: TextStyle(fontSize: 20),),
              SizedBox(width: 12,),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                width: 40,
                child: Center(
                    child: Text(
                  "${map['num']}",
                  style: TextStyle(fontSize: 20),
                )),
              ),

            ])),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
