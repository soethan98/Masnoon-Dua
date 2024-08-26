import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/providers/ui_dua.dart';
import 'package:masnoon_dua/providers/main_dua_controller.dart';

class DuaItem extends ConsumerWidget {
  final UiDua duaItem;


  const DuaItem({
    super.key,
    required this.duaItem,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                duaItem.dua.dua_title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                duaItem.dua.dua_arbic,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 26.0),
              ),
              Text(
                duaItem.dua.dua_desc,
                style: TextStyle(fontSize: 14.0),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[800]),
                child: duaItem.isPlaying
                    ? IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ref
                              .read(mainDuaControllerProvider.notifier)
                              .pause(duaItem);
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ref
                              .read(mainDuaControllerProvider.notifier)
                              .play(duaItem);
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
