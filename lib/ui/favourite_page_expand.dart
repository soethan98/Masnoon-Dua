import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dua_detail_page.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favourite_page.dart';

class ExpandPage extends StatefulWidget {
  Dua dua;

  ExpandPage(this.dua);
  @override
  _ExpandPageState createState() => _ExpandPageState();
}

class _ExpandPageState extends State<ExpandPage> {
  DatabaseHelper _helper = new DatabaseHelper();
  bool _isFav = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(8.0),
        child: ExpandablePanel(
          header: _buildFavCollapsed(),
          expanded: _buildFavExpand(),
        ),
      ),
    );
  }

  Widget _buildFavCollapsed() {
    return Column(children: <Widget>[
      Align(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: _isFav == true
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
          onPressed: () => deleteFav(),
        ),
      ),
      Text(
        widget.dua.dua_title,
        style: TextStyle(fontSize: 15.0),
      ),
    ]);
  }

  Widget _buildFavExpand() {
    return Column(
      children: <Widget>[
        Text(
          widget.dua.dua_arbic,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 20.0),
        ),
        Text(
          widget.dua.dua_desc,
          style: TextStyle(fontSize: 12.0),
        ),
        Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.grey[800]),
          child: isPlaying
              ? IconButton(
                  icon: Icon(
                    Icons.pause,
                    color: Colors.white,
                  ),
                  onPressed: () => pauseSound())
              : IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () => playSound(),
                ),
        )
      ],
    );
  }

  void playSound() async {
    if (advancedPlayer.state == AudioPlayerState.PAUSED) {
      await advancedPlayer.resume();
    } else {
      await audioCache.play(widget.dua.sound_url);
    }

    setState(() {
      isPlaying = true;
    });

    advancedPlayer.completionHandler = () {
      setState(() {
        isPlaying = false;
      });
    };
  }

  void pauseSound() {
    if (advancedPlayer.state == AudioPlayerState.PLAYING) {
      advancedPlayer.pause();
    }
    setState(() {
      isPlaying = false;
    });
  }

  void releaseAudio() {
    advancedPlayer.stop();
  }

  void deleteFav() async {
    int result = await _helper.deleteFavDua(widget.dua.dua_id);
    if (result != 0) removePrefValue(widget.dua.dua_id.toString());
  }

  removePrefValue(String _duaId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_duaId, false);

    setState(() {
      _isFav = false;
    });

    setState(() {
      favDuaList.remove(widget.dua);
    });
  }
}
