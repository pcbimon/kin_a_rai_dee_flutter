import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'model/food.dart';

class DatabaseHelper {
  static final _databaseName = "Food.db";
  static final _databaseVersion = 1;

  /// make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  /// The database when opened.
  late Database _database;
  Future<Database> get database async {
    // if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
create table $tableFood ( 
  $columnId integer primary key autoincrement, 
  $columnFoodName text not null,
  $columnFoodCategory text not null,
  $columnCalories double not null,
  $columnNationality text not null,
  $columnDescription text not null,
  $columnImg text not null)
''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<Food> insert(Food food) async {
    Database db = await instance.database;
    food.id = await db.insert(tableFood, food.toMap());
    return food;
  }

  Future<void> removeAllFood() async {
    Database db = await instance.database;
    await db.delete(tableFood);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Food>> queryAllRows() async {
    Database db = await instance.database;
    List<Food> foods = [];
    List<Map> maps = await db.query(tableFood);
    if (maps.isNotEmpty) {
      maps.forEach((element) {
        foods.add(new Food(
            element[columnFoodName],
            element[columnFoodCategory],
            element[columnCalories].toDouble(),
            element[columnNationality],
            element[columnDescription],
            element[columnImg]));
      });
    }
    return foods;
  }
}
