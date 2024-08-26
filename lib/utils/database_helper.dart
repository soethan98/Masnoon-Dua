import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:masnoon_dua/data/dua_data.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String favTable = 'fav_table';
  String colId = 'dua_id';
  String colTitle = 'dua_title';
  String colDescription = 'dua_desc';
  String colArbic = 'dua_arabic';
  String colSoundUrl = 'sound_url';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $favTable($colId INTEGER PRIMARY KEY, $colTitle TEXT,$colArbic TEXT, $colDescription TEXT, $colSoundUrl TEXT)');
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'masnoondua.db';
    var masnoonDuaDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return masnoonDuaDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<int> insertDua(Dua dua) async {
    var db = await this.database;
    int result = await db.insert(favTable, dua.toMap());
    return result;
  }

  Future<List<Map<String, dynamic>>> getFavMapList() async {
    var db = await this.database;
    var result = await db.query(favTable);
    return result;
  }

  Future<List<Dua>> getFavList() async {
    var favDuaMapList = await getFavMapList();
    int count = favDuaMapList.length;

    var favList = <Dua>[];

    for (int i = 0; i < count; i++) {
      favList.add(Dua.fromMapObject(favDuaMapList[i]));
    }

    return favList;
  }

  Future<bool> isDuaFavorite(Dua dua) async {
    // Query to check if the item exists in the favorites table
    final db = await this.database;

    final List<Map<String, dynamic>> result = await db.query(
      favTable, // Table name
      where: '$colId = ?', // Condition to match the itemId
      whereArgs: [dua.dua_id], // Value to match
    );

    // If the result is not empty, the item is a favorite
    return result.isNotEmpty;
  }

  Future<int> deleteFavDua(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $favTable WHERE $colId = $id');
    return result;
  }
}
