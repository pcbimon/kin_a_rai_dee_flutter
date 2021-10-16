import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/model/food.dart';
import 'dart:io';

class FoodViewImage extends StatelessWidget {
  final Food food;
  FoodViewImage(this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(food.foodName),
      ),
      body: Hero(
        transitionOnUserGestures: true,
        // tag on result screen will be same from first screen
        tag: food.img,
        child: SingleChildScrollView(
          child: Container(
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
                          // Change read from asset to FileImage
                          image: FileImage(File(food.img)),
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
                            child: Text(food.foodCategory,
                                style: TextStyle(fontSize: 14)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
