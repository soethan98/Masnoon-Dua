import 'package:flutter/material.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:masnoon_dua/ui/dua_item.dart';
import 'dua_item.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:masnoon_dua/utils/database_helper.dart';

bool isPlaying = false;
bool favValue = false;
Dua vDua;

class DuaDetail extends StatefulWidget {
  final DuaCategory duaCategory;

  DuaDetail(this.duaCategory);

  @override
  _DuaDetailState createState() => _DuaDetailState();
}

class _DuaDetailState extends State<DuaDetail> with WidgetsBindingObserver {
  List<Dua> duasList = new List();

  AppLifecycleState _lastLifecycleState;

  DatabaseHelper helper = DatabaseHelper();

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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
            // icon: Icon(
            //   Icons.favorite,
            //   color: Colors.red,
            // ),
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageView.builder(
            onPageChanged: (int pageChange) {
              debugPrint('$pageChange PageChange');
              if (advancedPlayer != null) {
                advancedPlayer.stop();
              }
              setState(() {
                isPlaying = false;
              });
            },
            controller: PageController(viewportFraction: 1),
            itemCount: duasList != null ? duasList.length : 0,
            itemBuilder: (context, index) {
              debugPrint('$index built');
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

  void _save() async {
    int result = await helper.insertDua(vDua);
    if (result != 0) addPrefValue(vDua.dua_id.toString());
  }

  void _delete() async {
    int result = await helper.deleteFavDua(vDua.dua_id);
    if (result != 0) removePrefValue(vDua.dua_id.toString());
  }
}
