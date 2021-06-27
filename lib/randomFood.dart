import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widget/inputCalories.dart';
import './widget/selectCategory.dart';

class RandomFood extends StatefulWidget {
  @override
  State<RandomFood> createState() => _RandomFoodState();
}

class _RandomFoodState extends State<RandomFood> {
  final List<String> foodNationality = [
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
  void onPressedCategory(int selectedIndex) {
    setState(() {
      _selectedCategory = selectedIndex;
      print(_selectedCategory);
    });
  }
  void onChangeCalories(double cal){
    setState(() {
      _selectedCalories = cal;
    });
  }
  void inputCustomCalories(BuildContext context){
    showModalBottomSheet(context: context, builder: (_){
      return inputCalories(_maxCalories,onChangeCalories);
    });
  }

  final List<String> foodCategory = ['คาว', 'หวาน'];

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
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          NumberFormat('#,###').format(_selectedCalories)+" Cal",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      onTap: (){
                        inputCustomCalories(context);
                      },
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Slider(
                            value: _selectedCalories, min: _minCalories, max: _maxCalories, onChanged: (val) {
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
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                        onChanged: (val) {},
                        hint: Text("กรุณาเลือกสัญชาติ"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
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
