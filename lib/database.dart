import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Menu.dart';

class DbHelper {
  Database _database;

  Future<Database> get dbInstance async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'warungapp.db'),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE menu(id INTEGER PRIMARY KEY, nama TEXT, jumlah INTEGER, harga INTEGER)");
    }, version: 1);
  }

  Future<void> addMenu(Menu menu) async {
    final db = await dbInstance;
    await db.insert('menu', menu.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Menu>> getMenu() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('menu');

    return List.generate(maps.length, (i) {
      return Menu(
          id: maps[i]['id'],
          nama: maps[i]['nama'],
          jumlah: maps[i]['jumlah'],
          harga: maps[i]['harga']);
    });
  }

  Future<void> updateMenu(Menu menu) async {
    final db = await dbInstance;
    await db.update('menu', menu.toMap(), where: 'id=?', whereArgs: [menu.id]);
  }

  Future<void> deleteMenu(menuId) async {
    final db = await dbInstance;
    await db.delete('menu', where: 'id=?', whereArgs: [menuId]);
  }
}
