import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/providers/favorite_controller.dart';
import 'package:masnoon_dua/ui/favorite_dua_item.dart';
import 'package:masnoon_dua/utils/dua_player.dart';


class FavouritePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FavouritePageState();
  }
}

class FavouritePageState extends ConsumerState<FavouritePage>
    with WidgetsBindingObserver {

  AppLifecycleState? _favLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    ref.read(favoriteControllerProvider.notifier).requestFavoriteList();
  }

  @override
  void dispose() {
    DuaPlayer().stop();

    super.dispose();
   
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _favLifecycleState = state;
    debugPrint('$state');
    if (_favLifecycleState == AppLifecycleState.paused ||
        _favLifecycleState == AppLifecycleState.inactive) {
      DuaPlayer().stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteControllerProvider);
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
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final item = favorites[index];
              return FavoriteDuaItem(
                duaItem: item,
                onRemoveFromFav: () {
                  ref
                      .read(favoriteControllerProvider.notifier)
                      .removeFromFavorite(item.dua);
                },
                onTogglePlayState: () {
                  if (item.isPlaying) {
                    ref
                        .read(favoriteControllerProvider.notifier)
                        .pauseSound(item.dua);
                  } else {
                    ref
                        .read(favoriteControllerProvider.notifier)
                        .playSound(item.dua.sound_url!);
                  }
                },
              );
            },
          )
        ],
      ),
    );
  }
}
