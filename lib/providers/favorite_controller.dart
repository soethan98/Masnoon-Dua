import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/providers/favorite_dua.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_controller.g.dart';

@riverpod
class FavoriteController extends _$FavoriteController {
  @override
  List<FavoriteDua> build() {
    DuaPlayer().listenToAudioCompletion().listen((_) {
      if (state.any((element) => element.isPlaying)) {
        state = state.map((item) => item.copywith(isPlaying: false)).toList();
      }
    });
    return <FavoriteDua>[];
  }

  void requestFavoriteList() async {
    final result = await DatabaseHelper().getFavList();

    state =
        result.map((item) => FavoriteDua(dua: item, isPlaying: false)).toList();
  }

  void removeFromFavorite(Dua dua) async {
    await DatabaseHelper().deleteFavDua(dua.dua_id);
    if (state.any((item) => item.dua.dua_id == dua.dua_id)) {
      final updatedFavorites =
          state.where((i) => i.dua.dua_id != dua.dua_id).toList();
      state = updatedFavorites;
    }
  }

  void playSound(String sound_url) async {
    if (DuaPlayer().isPause()) {
      bool isCurrentDuaActive = DuaPlayer().currentUrl == sound_url;
      if (isCurrentDuaActive) {
        await DuaPlayer().resume();
      }
    } else {
      await DuaPlayer().play(sound_url);
    }
    state = state
        .map((i) =>
            i.copywith(isPlaying: i.dua.sound_url == sound_url ? true : false))
        .toList();
  }

  void pauseSound(Dua dua) async {
    bool isCurrentDuaActive = DuaPlayer().currentUrl == dua.sound_url;
    if (isCurrentDuaActive) {
      if (DuaPlayer().isPlaying()) {
        await DuaPlayer().pause();
        state = state.map((i) => i.copywith(isPlaying: false)).toList();
      }
    }
  }
}


extension ListExt<T> on List<T>?{
  bool isNullOrEmpty(){
    if(this == null || this!.isEmpty){
      return true;
    }
    return false;
  }
}