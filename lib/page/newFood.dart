import 'package:flutter/material.dart';
class newFood extends StatelessWidget {
  final Function createFood;
  final foodNameController = TextEditingController();
  newFood(this.createFood);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มเมนูอาหารใหม่'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'ชื่ออาหาร'),
              keyboardType: TextInputType.number,
              controller: foodNameController,
              onFieldSubmitted: (value) => {
//                if (_formKey.currentState!.validate()) {submitData()}
              },
            ),
          ],
        ),
      ),
    );
  }
}
