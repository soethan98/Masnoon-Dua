class Dua {
  int dua_id;
  String dua_title;
  String dua_arbic;
  String dua_desc;
  String image_path;
  String sound_url;

  Dua(this.dua_id, this.dua_title, this.dua_arbic, this.dua_desc,
      {this.sound_url});


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (dua_id != null) {
      map['id'] = dua_id;
    }
    map['title'] = dua_title;
    map['arbic'] = dua_arbic;
    map['description'] = dua_desc;
    map['sound_url'] = sound_url;

    return map;
  }

  // Extract a Note object from a Map object
  Dua.fromMapObject(Map<String, dynamic> map) {
    this.dua_id = map['id'];
    this.dua_title = map['title'];
    this.dua_desc = map['description'];
    this.dua_arbic = map['arbic'];
    this.sound_url = map['sound_url'];
  }


}
