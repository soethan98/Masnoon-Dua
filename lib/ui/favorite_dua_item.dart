import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:masnoon_dua/providers/favorite_dua.dart';

class FavoriteDuaItem extends StatelessWidget {
  final FavoriteDua duaItem;
  final bool isFav;
  final VoidCallback onRemoveFromFav; 
  final VoidCallback onTogglePlayState;
  const FavoriteDuaItem(
      {super.key,
      required this.duaItem,
      this.isFav = true,
      required this.onRemoveFromFav,
      required this.onTogglePlayState,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(8.0),
        child: ExpandablePanel(
          header: Column(children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: isFav == true
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                onPressed: onRemoveFromFav,
              ),
            ),
            Text(
              duaItem.dua.dua_title,
              style: TextStyle(fontSize: 15.0),
            ),
          ]),
          expanded: Column(
      children: <Widget>[
        Text(
          duaItem.dua.dua_arbic,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20.0),
        ),
        Text(
          duaItem.dua.dua_desc,
          style: TextStyle(fontSize: 12.0),
        ),
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[800]),
          child: duaItem.isPlaying
              ? IconButton(
                  icon: Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                  onPressed: () => onTogglePlayState())
              : IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () => onTogglePlayState(),
                ),
        )
      ],
    ),
          collapsed: SizedBox.shrink(),
        ),
      ),
    );
  }

}
