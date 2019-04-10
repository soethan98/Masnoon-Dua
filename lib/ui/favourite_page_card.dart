import 'package:flutter/material.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'favourite_page.dart';


class FavouriteCard extends StatefulWidget {

  Dua dua;

  FavouriteCard(this.dua);

  @override
  _FavouriteCardState createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 8.0,
      child: Container(
        child: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(500.0),
          // child: ,

        ),
        ),
      ),

    );
  }
}
