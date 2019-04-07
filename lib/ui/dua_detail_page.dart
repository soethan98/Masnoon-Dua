import 'dart:math';

import 'package:flutter/material.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:masnoon_dua/ui/dua_item.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:masnoon_dua/main.dart';
import 'dua_item.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool isPlaying = false;


class DuaDetail extends StatefulWidget {
  final int duaid;

  DuaDetail(this.duaid);

  @override
  _DuaDetailState createState() => _DuaDetailState();
}

class _DuaDetailState extends State<DuaDetail> with WidgetsBindingObserver {
  List<Dua> duasList = new List();




  AppLifecycleState _lastLifecycleState;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('initState');
    WidgetsBinding.instance.addObserver(this);
    setListDuas();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(right: 16.0,left: 16.0),
        child: PageView.builder(
          onPageChanged: (int pageChange) {
            if (advancedPlayer != null) {
              advancedPlayer.stop();
            }
            setState(() {
              isPlaying = false;
            });
          },
//        controller: PageController(viewportFraction: 0.85),
          itemCount: duasList != null ? duasList.length : 0,
          itemBuilder: (context, index) {

            final item = duasList[index];
            return DuaItem(item);
          },
        ),
      ),
    );
  }

  void setListDuas() {
    switch (widget.duaid) {
      case 1:
        duasList = societyDuas;
        break;
      case 2:
        duasList = travelDuas;
        break;
      case 3:
        duasList = namazDuas;
        break;
      case 4:
        duasList = foodDuas;
        break;
      case 5:
        duasList = dailyDuas;
        break;
      case 6:
        duasList = weatherDuas;
        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    debugPrint('$state');
    if (_lastLifecycleState == AppLifecycleState.paused ||
        _lastLifecycleState == AppLifecycleState.inactive) {
      if (advancedPlayer != null) advancedPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    if (advancedPlayer != null) {
      advancedPlayer.stop();
      audioCache.clearCache();
      isPlaying = false;
    }

    WidgetsBinding.instance.removeObserver(this);
  }




}
