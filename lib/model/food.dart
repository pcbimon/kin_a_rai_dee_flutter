import 'package:sqflite/sqflite.dart';

/// `food` table name
final String tableFood = 'food';

final String columnId = 'id';
final String columnFoodName = 'foodName';
final String columnFoodCategory = 'foodCategory';
final String columnCalories = 'calories';
final String columnNationality = 'nationality';
final String columnDescription = 'description';
final String columnImg = 'img';
final List<String> foodCategory = ['คาว', 'หวาน'];
final List<String> foodNationality = [
  'ไทย',
  'จีน',
  'ญี่ปุ่น',
  'ฝรั่งเศษ',
  'อเมริกา'
];
final double maxCalories = 2000;
final double minCalories = 0;

class Food {
  int? id;
  final String foodName;
  final String foodCategory;
  final double calories;
  final String nationality;
  final String description;
  final String img;
  Food(this.id, this.foodName, this.foodCategory, this.calories,
      this.nationality, this.description, this.img);
  Food.fromMap(Map map)
      : this.id = map[columnId] as int?,
        this.foodCategory = map[columnFoodCategory] as String,
        this.foodName = map[columnFoodName] as String,
        this.calories = map[columnCalories] as double,
        this.nationality = map[columnNationality] as String,
        this.description = map[columnDescription] as String,
        this.img = map[columnImg] as String;

  /// Convert to a record.
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnFoodName: foodName,
      columnFoodCategory: foodCategory,
      columnCalories: calories,
      columnNationality: nationality,
      columnDescription: description,
      columnImg: img,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
