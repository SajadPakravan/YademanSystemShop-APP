import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yad_sys/models/user_model.dart';

class YadSysDB {
  static final YadSysDB instance = YadSysDB._init();
  static Database? _database;

  YadSysDB._init();

  static const fileName = 'yademan.db';
  static const version = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory? externalDirectory = await getExternalStorageDirectory();
    String path = join(externalDirectory!.path, fileName);
    return await openDatabase(path, version: version, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS ${UserFields.tblName}('
        '${UserFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${UserFields.token} TEXT NOT NULL,'
        '${UserFields.name} VARCHAR(30) NOT NULL,'
        '${UserFields.phone} CHAR(11) NULL,'
        '${UserFields.email} VARCHAR(50) NOT NULL,'
        '${UserFields.avatar} TEXT NULL)');
  }

  Future<User> insert(User user) async {
    Database db = await instance.database;
    try {
      await YadSysDB.instance.deleteAll();
    } finally {}
    final id = await db.insert(UserFields.tblName, user.toJson());
    if (kDebugMode) {
      print("INSERT");
    }
    return user.copy(id: id);
  }

  Future<dynamic> getUser() async {
    Database db = await instance.database;
    // final result = await db.query(UserFields.tblName, where: "${UserFields.email} = '$email'");
    final result = await db.query(UserFields.tblName);
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    } else {
      return false;
    }
  }

  // Future<List<User>> getAllUser() async {
  //   Database db = await instance.database;
  //   final result = await db.query(UserFields.tblName);
  //   if (result.isEmpty) {
  //     return [];
  //   } else {
  //     return result.map((json) => User.fromJson(json)).toList();
  //   }
  // }

  Future<int> deleteAll() async {
    final db = await instance.database;
    if (kDebugMode) {
      print("DELETE");
    }
    return db.delete(UserFields.tblName);
  }

//
// Future<int> update(Cart cart) async {
//   final db = await instance.database;
//
//   return db.update(
//     tableCart,
//     cart.toJson(),
//     where: '${CartFields.id} = ?',
//     whereArgs: [cart.id],
//   );
// }
//
// Future<int> delete(int id) async {
//   final db = await instance.database;
//   return db.delete(
//     tableCart,
//     where: '${CartFields.id} = ?',
//     whereArgs: [id],
//   );
// }
//
//
// Future close() async {
//   final db = await instance.database;
//   db.close();
// }
}
