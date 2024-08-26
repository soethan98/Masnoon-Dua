import 'package:flutter/material.dart';
import 'package:masnoon_dua/utils/dua_list.dart';

import 'dua_detail_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          
          itemCount: duaName.length,
          itemBuilder: (context, index) {
            return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (context) {
         return  new DuaDetail(duaName[index]);
        }));
      },
      child: Stack(
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
              style: TextStyle(fontSize: 22.0, color: Colors.white),
            ),
          )
        ],
      ),
            );
          },
        ),
    );
  }

 
}
