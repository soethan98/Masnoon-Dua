import 'package:flutter/material.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'dart:ui' as ui;
import 'package:masnoon_dua/data/dua_data.dart';
import 'favourite_page_card.dart';

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() {
    return new FavouritePageState();
  }
}

class FavouritePageState extends State<FavouritePage> {
  DatabaseHelper helper = DatabaseHelper();
  List<Dua> favDuaList = new List();

  @override
  void initState() {
    super.initState();

    helper.getFavList().then((duaList) {
      favDuaList = duaList;
        

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
              child: Image.asset('assets/images/3.jpeg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity)),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          PageView.builder(
            itemBuilder: (context, index) {
              final item = favDuaList[index];
              return FavouriteCard(item);
            },
            scrollDirection: Axis.vertical,
            itemCount: favDuaList != null ? favDuaList.length : 0,
          )
        ],
      ),
    );
  }
}
