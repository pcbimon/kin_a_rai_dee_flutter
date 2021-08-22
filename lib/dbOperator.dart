import 'package:json_store/json_store.dart';

import 'model/food.dart';

class MyDB {
  List<Food> foods = [
    new Food('ผัดผักรวม', 'คาว', 500, 'ไทย', 'อาหารคาวเด่นปะจำชาติ',
        'assets/images/food1.jpg'),
    new Food('ข้าวผัด', 'คาว', 1000, 'ไทย', 'อาหารคาวเด่นประจำชาติ',
        'assets/images/food2.jpg'),
    new Food('สปาเก็ตตี้', 'คาว', 1500, 'อเมริกา', 'อาหารคาวเด่นประจำชาติ',
        'assets/images/food3.jpg')
  ];
  final _jsonStore = JsonStore(dbName: 'foodDB');
  MyDB();
  Future<List<Food>> loadFromStorage() async {
    Map<String, dynamic>? json = await JsonStore().getItem('foods');

    List<Food> _listfoods = json != null
        ? json['value'].map<Food>((foodJson) {
            return Food.fromJson(foodJson);
          }).toList()
        : [];
    return _listfoods;
  }

  initFood() async {
    final _jsonStore = JsonStore(dbName: 'foodDB');
    _jsonStore.clearDataBase();
    await saveToStorage(foods);
  }

  saveToStorage(List<Food> foods) async {
    await JsonStore().setItem('foods', {
      'value': foods.map((foodJson) {
        return foodJson.toJson();
      }).toList()
    });
  }
}
