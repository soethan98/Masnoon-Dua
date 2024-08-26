import 'package:masnoon_dua/providers/active_dua_provider.dart';
import 'package:masnoon_dua/providers/favorite_dua.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_dua_controller.g.dart';

@riverpod
class MainDuaController extends _$MainDuaController {
  @override
  List<FavoriteDua> build() {
    return <FavoriteDua>[];
  }

 void loadSongs(int categoryCode) {
    state = switch (categoryCode) {
      1 => societyDuas,
      2 => travelDuas,
      3 => namazDuas,
      4 => foodDuas,
      5 => dailyDuas,
      6 => weatherDuas,
      _ => []
    }
        .map((e) => FavoriteDua(dua: e, isPlaying: false))
        .toList();

     ref
          .read(activeDuaNotifierProvider.notifier)
          .updateCurrentActiveDua(state.first.dua);
  }



}
