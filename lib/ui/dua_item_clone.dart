import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:masnoon_dua/providers/favorite_dua.dart';

class DuaItemClone extends ConsumerWidget {
  final FavoriteDua duaItem;
  // final bool isFavorite;
  // final bool isPlaying;

  const DuaItemClone(
      {super.key,
      required this.duaItem,
      });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      decoration: BoxDecoration(
          border: Border.all(width: 2.0),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0, bottom: 4.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                duaItem.dua.dua_title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                duaItem.dua.dua_arbic,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 26.0),
              ),
              Text(
                duaItem.dua.dua_desc,
                style: TextStyle(fontSize: 14.0),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[800]),
                child: duaItem.isPlaying 
                    ? IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        onPressed: (){})
                    : IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: (){},
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class DuaItem extends StatefulWidget {
//   final Dua dua;
//   final bool isFavorite;
//   final bool isPlaying;

//   DuaItem(this.dua);

//   @override
//   DuaItemState createState() {
//     return new DuaItemState();
//   }
// }

// class DuaItemState extends State<DuaItem> {
//   String? mp3Uri;
//   final double barHeight = 55.0;

//   // DatabaseHelper helper = DatabaseHelper();

//   @override
//   void initState() {
//     super.initState();

//     checkPrefValue(widget.dua.dua_id);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         setState(() {
//           vDua = widget.dua;
//         });
//       }
//     });

//     DuaPlayer().listenToAudioCompletion().listen((_) {
//       if (mounted) {
//         setState(() {
//           isPlaying = false;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _buildDuaContent(context);
//   }

//   Widget _buildDuaContent(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 24.0, right: 24.0),
//       decoration: BoxDecoration(
//           border: Border.all(width: 2.0),
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0)),
//       child: Padding(
//         padding: EdgeInsets.only(top: 30.0, left: 8.0, right: 8.0, bottom: 4.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Text(
//                 widget.dua.dua_title,
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               Text(
//                 widget.dua.dua_arbic,
//                 textDirection: TextDirection.rtl,
//                 style: TextStyle(fontSize: 26.0),
//               ),
//               Text(
//                 widget.dua.dua_desc,
//                 style: TextStyle(fontSize: 14.0),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle, color: Colors.grey[800]),
//                 child: isPlaying
//                     ? IconButton(
//                         icon: Icon(
//                           Icons.pause,
//                           color: Colors.white,
//                         ),
//                         onPressed: () => pause())
//                     : IconButton(
//                         icon: Icon(
//                           Icons.play_arrow,
//                           color: Colors.white,
//                         ),
//                         onPressed: () => play(widget.dua.sound_url!),
//                       ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void pause() async {
//     if (DuaPlayer().isPlaying()) {
//       await DuaPlayer().pause();
//     }
//     setState(() {
//       isPlaying = false;
//     });
//   }

//   void play(String _url) async {
//     if (DuaPlayer().isPause()) {
//       await DuaPlayer().resume();
//     } else {
//       await DuaPlayer().play(_url);
//     }

//     setState(() {
//       isPlaying = true;
//     });
//   }

//   checkPrefValue(int _duaId) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       favValue = sharedPreferences.getBool(_duaId.toString()) ?? false;
//     });
//   }

//   void releaseAudio() {
//     DuaPlayer().stop();
//   }
// }
