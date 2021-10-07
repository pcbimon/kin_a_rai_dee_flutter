import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/model/food.dart';

class FoodDetail extends StatefulWidget {
  final Function createOrUpdateFood;
  Food? food;

  FoodDetail(this.createOrUpdateFood, [this.food]);

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final foodNameController = TextEditingController();

  final _random = new Random();

  final _formKey = GlobalKey<FormState>();

  submitData(BuildContext context, [int? id]) {
    Food food = new Food(
        id,
        foodNameController.text,
        foodCategory[_random.nextInt(1)],
        _random.nextInt(2000).toDouble(),
        foodNationality[_random.nextInt(4)],
        'ทดสอบ',
        'assets/images/food${_random.nextInt(2) + 1}.jpg');
    this.widget.createOrUpdateFood(food);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.food != null) {
      foodNameController.text = (widget.food)!.foodName;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มเมนูอาหารใหม่'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ชื่ออาหาร'),
                controller: foodNameController,
                validator: (val) {
                  if (val == null || val.length == 0) {
                    return 'กรุณากรอกชื่ออาหาร';
                  }
                  return null;
                },
                onFieldSubmitted: (value) => {
                  if (_formKey.currentState!.validate())
                    {submitData(context, (widget.food)!.id)}
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitData(context, (widget.food)!.id);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (widget.food == null)
                          ? Text('เพิ่มเมนูใหม่')
                          : Text('แก้ไขเมนู')
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
