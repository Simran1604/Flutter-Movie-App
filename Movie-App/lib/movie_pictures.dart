import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies/info.dart';

final List<Info> infoList=Info.getinfo();

class pic extends StatelessWidget {
  final List<Info> infoList=Info.getinfo();

   pic({Key? key, required this.index1,required this.index2}) : super(key: key);
  final int index1,index2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child:Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey.shade900,
              width: 5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: 
              [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 7
                ),
              ],
              ),
              child: Hero(
                tag: 'image$index2',
                child: Image.network(
                  infoList[index1].images[index2],
                ),
              ),
            ),
          ),
        ),
      );
  }
}