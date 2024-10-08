import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_category.dart';
import 'package:masnoon_dua/providers/active_dua_provider.dart';
import 'package:masnoon_dua/providers/main_dua_controller.dart';
import 'package:masnoon_dua/ui/dua_item.dart';
import 'package:masnoon_dua/utils/dua_player.dart';
import 'package:share_plus/share_plus.dart';

class DuaDetail extends ConsumerStatefulWidget {
  final DuaCategory duaCategory;

  DuaDetail(this.duaCategory);

  @override
  _DuaDetailState createState() => _DuaDetailState();
}

class _DuaDetailState extends ConsumerState<DuaDetail>
    with WidgetsBindingObserver {
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
              await DuaPlayer().stop();
              ref.read(mainDuaControllerProvider.notifier).stopPlayingDuas();
              ref
                  .read(activeDuaNotifierProvider.notifier)
                  .updateCurrentActiveDua(duas[pageChange].dua);
            },
            controller: PageController(viewportFraction: 1),
            itemCount: duas.length,
            itemBuilder: (context, index) {
              final item = duas[index];
              return DuaItem(
                duaItem: item,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lastLifecycleState = state;
    debugPrint('$state');
    if (_lastLifecycleState == AppLifecycleState.paused ||
        _lastLifecycleState == AppLifecycleState.inactive) {
      ref.read(mainDuaControllerProvider.notifier).stopPlayingDuas();
    }
  }

  @override
  void dispose() {
    DuaPlayer().stop();
    if (context.mounted) {
      ref.read(mainDuaControllerProvider.notifier).stopPlayingDuas();
    }
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }
}
