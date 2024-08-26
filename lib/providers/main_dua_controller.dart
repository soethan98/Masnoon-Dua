import 'package:masnoon_dua/providers/active_dua_provider.dart';
import 'package:masnoon_dua/providers/ui_dua.dart';
import 'package:masnoon_dua/utils/dua_list.dart';
import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_dua_controller.g.dart';

@riverpod
class MainDuaController extends _$MainDuaController {
  @override
  List<UiDua> build() {
    DuaPlayer().listenToAudioCompletion().listen((_) {
      if (state.any((element) => element.isPlaying)) {
        state = state.map((item) => item.copywith(isPlaying: false)).toList();
      }
    });
    return <UiDua>[];
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
        .map((e) => UiDua(dua: e, isPlaying: false))
        .toList();

    ref
        .read(activeDuaNotifierProvider.notifier)
        .updateCurrentActiveDua(state.first.dua);
  }

  void stopPlayingDuas() {
    if (state.any((e) => e.isPlaying)) {
      state = state.map((e) => e.copywith(isPlaying: false)).toList();
    }
  }

  void pause(UiDua dua) async {
    final currentPlayingUrl = DuaPlayer().currentUrl();
    if (currentPlayingUrl == null || currentPlayingUrl.isEmpty) {
      await DuaPlayer().stop();
    }
    if (currentPlayingUrl == dua.dua.sound_url) {
      if (DuaPlayer().isPlaying()) {
        await DuaPlayer().pause();
      }
    }
    stopPlayingDuas();
  }

  void play(UiDua favDua) async {
       if (DuaPlayer().isPause()) {
      bool isCurrentDuaActive = DuaPlayer().currentUrl == favDua.dua.sound_url;
      if (isCurrentDuaActive) {
        await DuaPlayer().resume();
      }
    } else {
      await DuaPlayer().play(favDua.dua.sound_url!);
    }

    state = state
        .map((e) =>
            e.dua.dua_id == favDua.dua.dua_id ? e.copywith(isPlaying: true) : e)
        .toList();
  }
}
