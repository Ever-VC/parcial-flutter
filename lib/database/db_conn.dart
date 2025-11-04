import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteConnection {
  static Database? _database;
  static final SqliteConnection _instance = SqliteConnection._getInstance();
  final String dbName = 'gastos.db';
  
  SqliteConnection._getInstance();

  factory SqliteConnection() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database?> _initDatabase() async {
    String part1 = await getDatabasesPath();
    String path = join(part1, dbName);

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE gasto (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        monto REAL NOT NULL,
        categoria TEXT NOT NULL,
        descripcion TEXT NOT NULL,
        fecha TEXT NOT NULL
      )
    ''');
  }
}