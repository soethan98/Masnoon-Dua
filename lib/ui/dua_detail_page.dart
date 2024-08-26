import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/providers/active_dua_provider.dart';
import 'package:masnoon_dua/providers/main_dua_controller.dart';
import 'package:masnoon_dua/ui/dua_item.dart';
import 'package:masnoon_dua/ui/dua_item_clone.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:share_plus/share_plus.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(mainDuaControllerProvider.notifier)
          .loadSongs(widget.duaCategory.catId);
     
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentActiveDua = ref.watch(activeDuaNotifierProvider);
    final duas = ref.watch(mainDuaControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          Builder(builder: (context) {
            final isCurrentDuaFavorite =
                ref.watch(isCurrentDuaFavoriteProvider);

            return IconButton(
              icon: isCurrentDuaFavorite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(Icons.favorite_border, color: Colors.black),
              onPressed: () {
                isCurrentDuaFavorite
                    ? ref
                        .read(isCurrentDuaFavoriteProvider.notifier)
                        .removeFromFavorite(currentActiveDua!)
                    : ref
                        .read(isCurrentDuaFavoriteProvider.notifier)
                        .addToFavorite(currentActiveDua!);
              },
            );
          }),
          if (currentActiveDua != null)
            IconButton(
              icon: Icon(Icons.share, color: Colors.black),
              onPressed: () {
                Share.share(
                    '${currentActiveDua.dua_title}\n${currentActiveDua.dua_arbic}\n${currentActiveDua.dua_desc}');
              },
            )
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
                  .updateCurrentActiveDua(duas[pageChange].dua);

              setState(() {
                isPlaying = false;
              });
            },
            controller: PageController(viewportFraction: 1),
            itemCount: duas.length,
            itemBuilder: (context, index) {
              final item = duas[index];
              return DuaItemClone(
                duaItem: item,
              
              );
            },
          ),
        ),
      ),
    );
  }

  // void setListDuas() {
  //   switch (widget.duaCategory.catId) {
  //     case 1:
  //       duasList = societyDuas;
  //       break;
  //     case 2:
  //       duasList = travelDuas;
  //       break;
  //     case 3:
  //       duasList = namazDuas;
  //       break;
  //     case 4:
  //       duasList = foodDuas;
  //       break;
  //     case 5:
  //       duasList = dailyDuas;
  //       break;
  //     case 6:
  //       duasList = weatherDuas;
  //       break;
  //   }
  // }

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

    // DuaPlayer().dispose();
    isPlaying = false;

    if (vDua != null) {
      vDua = null;
    }

    WidgetsBinding.instance.removeObserver(this);
  }

  // void _save() async {
  //   int result = await helper.insertDua(vDua!);
  //   if (result != 0) addPrefValue(vDua!.dua_id.toString());
  // }

  // void _delete() async {
  //   int result = await helper.deleteFavDua(vDua!.dua_id);
  //   if (result != 0) removePrefValue(vDua!.dua_id.toString());
  // }

  // addPrefValue(String _duaId) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(_duaId, true);
  //   setState(() {
  //     favValue = true;
  //   });
  // }

  // removePrefValue(String _duaId) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool(_duaId, false);
  //   setState(() {
  //     favValue = false;
  //   });
  // }

  // checkPrefForFirstIndex(int _duaId) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     favValue = sharedPreferences.getBool(_duaId.toString()) ?? false;
  //   });
  // }
}
