import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmyfooddelivery/componenets/Image_view.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Data/dummydata.dart';

class item_wid extends StatefulWidget {
  const item_wid(
      {required this.inc,
      required this.dec,
      required this.item,
      required this.count,
      super.key});

  final Item item;
  final List count;
  final void Function(int i) inc;
  final void Function(int i) dec;

  @override
  State<item_wid> createState() => _item_widState();
}

class _item_widState extends State<item_wid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => ImageDialog(widget.item.imageurl));
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
                    image: widget.item.imageurl,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Text(widget.item.name),
            tileColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(color: Colors.black),
            ),
            subtitle: Text(" \$ ${widget.item.price}"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      widget.dec(widget.item.num);
                    });
                  },
                  child: Icon(Icons.remove)),
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
                  "${widget.count[widget.item.num]}",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      widget.inc(widget.item.num);
                    });
                  },
                  child: Icon(Icons.add)),
            ])),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
