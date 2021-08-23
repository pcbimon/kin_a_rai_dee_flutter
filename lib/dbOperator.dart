import 'package:sqflite/sqflite.dart';

import 'model/food.dart';

class MyDB {
  /// The database when opened.
  late Database db;
  // Open the database.
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableFood ( 
  $columnId integer primary key autoincrement, 
  $columnFoodName text not null,
  $columnFoodCategory text not null,
  $columnCalories integer not null,
  $columnNationality text not null,
  $columnDescription text not null,
  $columnImg text not null)
''');
    });
  }

  /// Insert a Food.
  Future<Food> insert(Food food) async {
    food.id = await db.insert(tableFood, food.toMap());
    return food;
  }

  /// Get a Food.
  Future<Food?> getFoodById(int id) async {
    List<Map> maps = await db.query(tableFood,
        columns: [
          columnId,
          columnFoodName,
          columnFoodCategory,
          columnCalories,
          columnNationality,
          columnDescription,
          columnImg
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Food.fromMap(maps.first);
    }
    return null;
  }

  /// Delete a food.
  Future<int> delete(int id) async {
    return await db.delete(tableFood, where: '$columnId = ?', whereArgs: [id]);
  }

  /// Update a food.
  Future<int> update(Food food) async {
    return await db.update(tableFood, food.toMap(),
        where: '$columnId = ?', whereArgs: [food.id!]);
  }

  /// Close database.
  Future close() async => db.close();
}
