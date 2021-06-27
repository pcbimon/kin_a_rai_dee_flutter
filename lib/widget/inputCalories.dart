import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class inputCalories extends StatefulWidget {
  final double maxCalories;
  final Function setCalories;
  inputCalories(this.maxCalories,this.setCalories);

  @override
  _inputCaloriesState createState() => _inputCaloriesState();
}

class _inputCaloriesState extends State<inputCalories> {
  final calController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? validateCalories(double maxCal,String? currentCal){
    if(currentCal != null && currentCal.isNotEmpty && double.parse(currentCal)>maxCal){
      String maxStr = NumberFormat('#,###').format(maxCal);
      return 'Your calories is over $maxStr';
    }
    return null;
  }
  void submitData() {
    final enterCal = calController.text;
    widget.setCalories(double.parse(enterCal));
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Selected Calories'),
                  keyboardType: TextInputType.number,
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (val){
                    if(val != null && double.parse(val)>widget.maxCalories){
                      String maxStr = NumberFormat('#,###').format(widget.maxCalories);
                      return 'Your calories is over $maxStr';
                    }
                    return null;
                  },
                  controller: calController,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()){
                        submitData();
                      }
                    },
                    child: Text(
                      'Choose!!!',
                      textAlign: TextAlign.center,
                    ))
              ],
            ),
          )),
    );
  }
}
