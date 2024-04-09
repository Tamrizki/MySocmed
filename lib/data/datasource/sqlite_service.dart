import 'dart:io';
import 'package:my_socmed/data/models/user_relation_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlliteService {
  final String _databaseName = 'my_socmed.db';

  final String _tabelName = 'relationState';
  final String userId = 'userId';
  final String likeState = 'likeState';
  final String friendState = 'friendState';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initializeDB();
    return _database!;
  }

  Future _initializeDB() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _databaseName);
    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future _onCreate(Database db, int verson) async {
    await db.execute(
        'CREATE TABLE $_tabelName ($userId TEXT PRIMARY KEY, $likeState INTEGER NULL, $friendState INTEGER NULL)');
  }

  Future<List<UserRealtionModel>?> fetchData() async {
    final data = await _database!.query(_tabelName);
    List<UserRealtionModel> result =
        data.map((state) => UserRealtionModel.fromJson(state)).toList();
    return result;
  }

  Future<String> insert(Map<String, dynamic> data) async {
    final query = await _database!.insert(_tabelName, data);
    return query.toString();
  }

  Future<int> update(Map<String, dynamic> data) async {
    final query = await _database!.update(_tabelName,
        {likeState: data[likeState], friendState: data[friendState]},
        where: '$userId = ?', whereArgs: [data[userId]]);
    fetchData();
    return query;
  }
}
