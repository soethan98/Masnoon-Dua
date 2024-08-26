import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
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

    ref.read(isCurrentDuaFavoriteProvider.notifier).isDuaFavorite(dua);
  }
}

@riverpod
class IsCurrentDuaFavorite extends _$IsCurrentDuaFavorite {
  @override
  bool build() {
    return false;
  }

  isDuaFavorite(Dua dua) async {
    final result = await DatabaseHelper().isDuaFavorite(dua);
    state = result;
  }

  void removeFromFavorite(Dua dua) async {
    await DatabaseHelper().deleteFavDua(dua.dua_id);
    state = false;
  }

  void addToFavorite(Dua dua) async {
    await DatabaseHelper().insertDua(dua);
   state = true;
  }
}
