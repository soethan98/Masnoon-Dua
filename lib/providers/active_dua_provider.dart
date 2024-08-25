import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/providers/favorite_dua.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'active_dua_provider.g.dart';

@riverpod
class ActiveDuaNotifier extends _$ActiveDuaNotifier {
  @override
  Dua? build() {
    return null;
  }

  updateCurrentActiveDua(Dua dua) {
    state = dua;
  }
}
