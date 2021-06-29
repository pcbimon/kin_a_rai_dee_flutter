import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './model/food.dart';
import './resultFood.dart';
import './widget/inputCalories.dart';
import './widget/selectCategory.dart';

class RandomFood extends StatefulWidget {
  @override
  State<RandomFood> createState() => _RandomFoodState();
}

class _RandomFoodState extends State<RandomFood> {
  List<String> foodNationality = [
    'ไทย',
    'จีน',
    'ญี่ปุ่น',
    'ฝรั่งเศษ',
    'อเมริกา'
  ];
  int _selectedCategory = 0;
  double _maxCalories = 2000;
  double _minCalories = 0;
  double _selectedCalories = 500;
  String _selectNationality = 'ไทย';
  List<Food> foods = [
    new Food('ผัดผักรวม', 'คาว', 500, 'ไทย', 'อาหารคาวเด่นปะจำชาติ',
        'assets/images/food1.jpg'),
    new Food('ข้าวผัด', 'คาว', 1000, 'ไทย', 'อาหารคาวเด่นประจำชาติ',
        'assets/images/food2.jpg'),
    new Food('สปาเก็ตตี้', 'คาว', 1500, 'อเมริกา', 'อาหารคาวเด่นประจำชาติ',
        'assets/images/food3.jpg')
  ];
  void onPressedCategory(int selectedIndex) {
    setState(() {
      _selectedCategory = selectedIndex;
      print(_selectedCategory);
    });
  }

  void onChangeCalories(double cal) {
    setState(() {
      _selectedCalories = cal;
    });
  }

  void inputCustomCalories(BuildContext context, double currentCal) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return inputCalories(_maxCalories, currentCal, onChangeCalories);
        });
  }

  void onChangeNationality(String? selectNational) {
    setState(() {
      _selectNationality = selectNational!;
    });
  }

  final List<String> foodCategory = ['คาว', 'หวาน'];
  final _random = new Random();
  void randomFood(BuildContext context) {
    //Filter food
    List<Food> filteredFood = foods
        .where((f) =>
            f.foodCategory == foodCategory[_selectedCategory] &&
            f.calories <= _selectedCalories &&
            f.nationality == _selectNationality)
        .toList();
    if (filteredFood.length > 0) {
      Food getRandomFood = filteredFood[_random.nextInt(filteredFood.length)];
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultFood(getRandomFood),
          ));
    } else {
      final snackBar = SnackBar(
        content: Text('ไม่มีข้อมูลอาหารตามตัวเลือกข้างต้น'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // Food getRandomFood = foods[_random.nextInt(foods.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "ประเภทอาหาร",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        category(
                            foodCategory, _selectedCategory, onPressedCategory)
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "พลังงาน",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          NumberFormat('#,###').format(_selectedCalories) +
                              " Cal",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        inputCustomCalories(context, _selectedCalories);
                      },
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Slider(
                            value: _selectedCalories,
                            min: _minCalories,
                            max: _maxCalories,
                            onChanged: (val) {
                              onChangeCalories(val);
                            }))
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "สัญชาติ",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        items: foodNationality.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        value: _selectNationality,
                        onChanged: (val) {
                          onChangeNationality(val);
                        },
                        hint: Text("กรุณาเลือกสัญชาติ"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  randomFood(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.shuffle), Text("Random Food")],
                ))
          ],
        ),
      ),
    );
  }
}
