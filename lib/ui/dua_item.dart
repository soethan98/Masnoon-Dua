import 'package:flutter/material.dart';
import 'package:masnoon_dua/data/dua_data.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:masnoon_dua/utils/database_helper.dart';
import 'dua_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DuaItem extends StatefulWidget {
  Dua dua;

  DuaItem(this.dua);

  @override
  DuaItemState createState() {
    return new DuaItemState();
  }
}

class DuaItemState extends State<DuaItem> {
  String mp3Uri;
  final double barHeight = 55.0;

  DatabaseHelper helper = DatabaseHelper();
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    


    checkPrefValue(widget.dua.dua_id);
    setState(() {
      vDua = widget.dua;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildDuaContent(context);
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  Widget _buildDuaContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 10.0),
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
                widget.dua.dua_title,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                widget.dua.dua_arbic,
                textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 26.0),
              ),
              Text(
                widget.dua.dua_desc,
                style: TextStyle(fontSize: 14.0),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[800]),
                child: isPlaying
                    ? IconButton(
                        icon: Icon(
                          Icons.pause,
                          color: Colors.white,
                        ),
                        onPressed: () => pause())
                    : IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () => play(widget.dua.sound_url),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void pause() {
    if (advancedPlayer.state == AudioPlayerState.PLAYING) {
      advancedPlayer.pause();
    }
    setState(() {
      isPlaying = false;
    });
  }

  void play(String _url) async {
    if (advancedPlayer.state == AudioPlayerState.PAUSED) {
      await advancedPlayer.resume();
    } else {
      await audioCache.play(_url);
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

  checkPrefValue(int _duaId) async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      favValue = sharedPreferences.getBool(_duaId.toString());
    });
  }

  void releaseAudio() {
    advancedPlayer.stop();
  }
}
