import 'package:flutter/material.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:masnoon_dua/utils/dua_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: duaName.length,
        itemBuilder: (context, index) {
          return Stack(
            alignment: Alignment(0.0, 0.0),
            children: <Widget>[
              Container(
                child: Image.asset(
                  duaName[index].imagePath,
                  fit: BoxFit.cover,
                  width: 500,
                  height: 150.0,
                ),
              ),
              Container(
                child: Text(
                  duaName[index].duaType,
                  style: TextStyle(fontSize: 22.0,color: Colors.white),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
