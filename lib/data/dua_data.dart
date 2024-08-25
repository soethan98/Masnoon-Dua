class Dua {
  int dua_id;
  String dua_title;
  String dua_arbic;
  String dua_desc;
  String? sound_url;

  Dua(this.dua_id, this.dua_title, this.dua_arbic, this.dua_desc,
      {this.sound_url});

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
   return {
      'dua_id': dua_id,
      'dua_title': dua_title,
      'dua_arabic': dua_arbic,
      'dua_desc': dua_desc,
      'sound_url': sound_url,
    };
  }

  // Extract a Note object from a Map object
  factory Dua.fromMapObject(Map<String, dynamic> map) {
    return Dua(
        map['dua_id'], map['dua_title'], map['dua_arabic'], map['dua_desc'],
        sound_url: map['sound_url']);
  }
}
