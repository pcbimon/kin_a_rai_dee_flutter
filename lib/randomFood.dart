import 'package:flutter/material.dart';

class RandomFood extends StatelessWidget {
  final List<String> foodCategory = [
    'ไทย',
    'จีน',
    'ญี่ปุ่น',
    'ฝรั่งเศษ',
    'อเมริกา'
  ];
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
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(30),
                          child: Text("ของคาว"),
                        ),
                      ),
                      Card(
                        child: Container(
                          margin: EdgeInsets.all(30),
                          child: Text("ของหวาน"),
                        ),
                      ),
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
                      items: foodCategory.map((String value) {
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
