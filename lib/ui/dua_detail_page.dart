import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/providers/active_dua_provider.dart';
import 'package:masnoon_dua/ui/dua_item_clone.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:masnoon_dua/ui/dua_item.dart';
import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:share_plus/share_plus.dart';
import 'dua_item.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:ui' as ui;
import 'dart:ui';

Dua? vDua;
// AudioPlayer? advancedPlayer;
// AudioCache? audioCache;
bool isPlaying = false;
bool favValue = false;

class DuaDetail extends ConsumerStatefulWidget {
  final DuaCategory duaCategory;

  DuaDetail(this.duaCategory);

  @override
  _DuaDetailState createState() => _DuaDetailState();
}

class _DuaDetailState extends ConsumerState<DuaDetail>
    with WidgetsBindingObserver {
  List<Dua> duasList = [];

  AppLifecycleState? _lastLifecycleState;

  DatabaseHelper helper = DatabaseHelper();
  Dua? dua;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setListDuas();

    checkPrefForFirstIndex(duasList[0].dua_id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(activeDuaNotifierProvider.notifier)
          .updateCurrentActiveDua(duasList[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          IconButton(
            icon: favValue == true
                ? Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              favValue == true ? _delete() : _save();
            },
          ),
          Builder(builder: (context) {
            final currentActiveDua = ref.watch(activeDuaNotifierProvider);
            if (currentActiveDua == null) {
              return SizedBox.shrink();
            }

            return IconButton(
              icon: Icon(Icons.share, color: Colors.black),
              onPressed: () {
                Share.share(
                    '${currentActiveDua.dua_title}\n${currentActiveDua.dua_arbic}\n${currentActiveDua.dua_desc}');
              },
            );
          })
        ],
      ),
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageView.builder(
            onPageChanged: (int pageChange) async {
              debugPrint('PageChange -- $pageChange');
              await DuaPlayer().stop();
              ref
                  .read(activeDuaNotifierProvider.notifier)
                  .updateCurrentActiveDua(duasList[pageChange]);

              setState(() {
                isPlaying = false;
              });
            },
            controller: PageController(viewportFraction: 1),
            itemCount: duasList.length,
            itemBuilder: (context, index) {
              final item = duasList[index];
              return DuaItem(item);
            },
          ),
        ),
      ),
    );
  }

  void setListDuas() {
    switch (widget.duaCategory.catId) {
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
      DuaPlayer().stop();
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    DuaPlayer().dispose();
    isPlaying = false;

    if (vDua != null) {
      vDua = null;
    }

    WidgetsBinding.instance.removeObserver(this);
  }

  void _save() async {
    int result = await helper.insertDua(vDua!);
    if (result != 0) addPrefValue(vDua!.dua_id.toString());
  }

  void _delete() async {
    int result = await helper.deleteFavDua(vDua!.dua_id);
    if (result != 0) removePrefValue(vDua!.dua_id.toString());
  }

  addPrefValue(String _duaId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_duaId, true);
    setState(() {
      favValue = true;
    });
  }

  removePrefValue(String _duaId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_duaId, false);
    setState(() {
      favValue = false;
    });
  }

  checkPrefForFirstIndex(int _duaId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      favValue = sharedPreferences.getBool(_duaId.toString()) ?? false;
    });
  }
}
