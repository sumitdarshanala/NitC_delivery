import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget{
   Home({required this.user,super.key});
  final user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
              child: Image(image: AssetImage('lib/assets/icon/deliver.png'))),
          const SizedBox(
            height: 30,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text("logged In as ${user.email}"),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}