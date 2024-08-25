import 'package:masnoon_dua/data/dua_data.dart';

class FavoriteDua {
  final Dua dua;
  final bool isPlaying;

  FavoriteDua({
    required this.dua,
    this.isPlaying = false
  });


FavoriteDua  copywith({
    bool? isPlaying
  }){
    return FavoriteDua(dua: this.dua,isPlaying: isPlaying ?? this.isPlaying);
  }
}