import 'package:masnoon_dua/data/dua_data.dart';

class UiDua {
  final Dua dua;
  final bool isPlaying;

  UiDua({required this.dua, this.isPlaying = false});

  UiDua copywith({bool? isPlaying}) {
    return UiDua(dua: this.dua, isPlaying: isPlaying ?? this.isPlaying);
  }
}
