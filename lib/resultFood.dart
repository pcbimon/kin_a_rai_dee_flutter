import 'package:flutter/material.dart';
import './model/food.dart';

class ResultFood extends StatelessWidget {
  final Food food;
  ResultFood(this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('นี่ไงเจอแล้ว'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image(
                      image: AssetImage(food.img),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 300,
              child: Card(
                elevation: 10,
                child: Column(
                  children: [
                    Container(
                      child: FittedBox(
                        child: Text(
                          food.foodName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: FittedBox(
                        child:
                            Text(food.foodCategory, style: TextStyle(fontSize: 14)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
