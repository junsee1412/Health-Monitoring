import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/data.dart';
import '../models/user.dart';

class DBProvider {
  static const int _version = 1;
  static const String _dbName = 'Jellyfish.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName,),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, gender INTEGER, height INTEGER, weight INTEGER)',);
        await db.execute('CREATE TABLE IF NOT EXISTS measure(id INTEGER PRIMARY KEY AUTOINCREMENT, HR INTEGER, SpO2 INTEGER, RR INTEGER, ABP INTEGER, date TEXT)',);
      },
      version: _version,
    );
  }

  static Future<int> insertUser(User row) async {
    Database db = await _getDB();
    return db.insert('user', row.toMap());
  }

  static Future<int> updateUser(User row) async {
    Database db = await _getDB();
    return db.update('user', row.toMap(), where: 'id = ?', whereArgs: [row.id]);
  }

  static Future<List<User>?> getUsers() async {
    Database db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
        gender: maps[i]['gender'],
        height: maps[i]['height'],
        weight: maps[i]['weight'],
      );
    });
  }

  static Future<int> insertMeasure(DataMonitor row) async {
    Database db = await _getDB();
    return db.insert('measure', row.toMap());
  }
  static Future<List<DataMonitor>> getMeasures() async {
    Database db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query('measure');
    if (maps.isEmpty) {
      return [];
    }
    return List.generate(maps.length, (i) {
      return DataMonitor(
        hr: maps[i]['HR'],
        spO2: maps[i]['SpO2'],
        rr: maps[i]['RR'],
        abp: maps[i]['ABP'],
      );
    });
  }
}