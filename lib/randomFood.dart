import 'package:flutter/material.dart';
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
  void onPressedCategory(int selectedIndex) {
    setState(() {
      _selectedCategory = selectedIndex;
      print(_selectedCategory);
    });
  }

  final List<String> foodCategory = ['คาว', 'หวาน'];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "500 Cal",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Slider(
                          value: 500, min: 0, max: 1000, onChanged: (val) {}))
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
    );
  }
}
