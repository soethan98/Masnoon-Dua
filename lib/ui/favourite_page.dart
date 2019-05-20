import 'package:flutter/material.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'dart:ui' as ui;
import 'package:masnoon_dua/data/dua_data.dart';
import 'favourite_page_expand.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import 'dua_detail_page.dart';

List<Dua> favDuaList = new List();

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() {
    return new FavouritePageState();
  }
}

class FavouritePageState extends State<FavouritePage> with WidgetsBindingObserver {
  DatabaseHelper helper = DatabaseHelper();

  AppLifecycleState _favLifecycleState;

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addObserver(this);

    helper.getFavList().then((duaList) {
      setState(() {
        favDuaList = duaList;
      });
    });
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
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _favLifecycleState = state;
    debugPrint('$state');
    if (_favLifecycleState == AppLifecycleState.paused ||
        _favLifecycleState == AppLifecycleState.inactive) {
      if (advancedPlayer != null) advancedPlayer.stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('assets/images/3.jpeg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          ListView.builder(
            itemCount: favDuaList != null ? favDuaList.length : 0,
            itemBuilder: (context, index) {
              final item = favDuaList[index];
              return ExpandPage(item);
            },
          )
        ],
      ),
    );
  }
}
