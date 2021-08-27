import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/model/food.dart';

class newFood extends StatefulWidget {
  final Function createFood;

  newFood(this.createFood);

  @override
  State<newFood> createState() => _newFoodState();
}

class _newFoodState extends State<newFood> {
  final foodNameController = TextEditingController();

  final _random = new Random();

  final _formKey = GlobalKey<FormState>();

  submitData(BuildContext context) {
    Food newFood = new Food(
        null,
        foodNameController.text,
        foodCategory[_random.nextInt(1)],
        _random.nextInt(2000).toDouble(),
        foodNationality[_random.nextInt(4)],
        '123',
        'assets/images/food${_random.nextInt(2) + 1}.jpg');
    this.widget.createFood(newFood);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  if (_formKey.currentState!.validate()) {submitData(context)}
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      submitData(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), Text('เพิ่มเมนูใหม่')],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
