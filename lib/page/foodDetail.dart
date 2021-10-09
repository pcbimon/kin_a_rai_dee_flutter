import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kin_a_rai_dee/model/food.dart';
import 'package:kin_a_rai_dee/widget/inputCalories.dart';
import 'package:kin_a_rai_dee/widget/selectCategory.dart';

import '../utils.dart';

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class FoodDetail extends StatefulWidget {
  final Function createOrUpdateFood;
  final Food? food;

  FoodDetail(this.createOrUpdateFood, [this.food]);

  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  final foodNameController = TextEditingController();
  final foodDescController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  int _selectedCategory = 0;
  double _selectedCalories = 500;
  String _selectNationality = 'ไทย';
  String _selectedImage = '';
  // XFile? _selectedImage;
  void initState() {
    // initState for init value only , setState not update from init Food
    if (widget.food != null) {
      foodNameController.text = (widget.food)!.foodName;
      foodDescController.text = (widget.food)!.description;
      _selectedCategory = (widget.food)!.foodCategory == "คาว" ? 0 : 1;
      _selectedCalories = (widget.food)!.calories;
      _selectNationality = (widget.food)!.nationality;
      _selectedImage = (widget.food)!.img;
    }
    super.initState();
  }

  submitData(BuildContext context, [int? id]) {
    Food food = new Food(
        id,
        foodNameController.text,
        _selectedCategory == 0 ? "คาว" : "หวาน",
        _selectedCalories,
        _selectNationality,
        foodDescController.text,
        _selectedImage);
    this.widget.createOrUpdateFood(food);
    Navigator.pop(context);
    Utils.showSnackBar(context, "Update Foods List");
  }

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
          return InputCalories(maxCalories, currentCal, onChangeCalories);
        });
  }

  void onChangeNationality(String? selectNational) {
    setState(() {
      _selectNationality = selectNational!;
    });
  }

  Future<void> onPickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File tmpFile = File(image.path);
      // Get the path to the apps directory so we can save the file to it.
      final String path = await Utils.createFolderInAppDocDir('FoodImg');
      final String fileName = basename(image.path); // Filename
      // Save the file by copying it to the new location on the device.
      tmpFile = await tmpFile.copy('$path$fileName');

      setState(() {
        _selectedImage = tmpFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.food == null)
            ? Text('เพิ่มเมนูอาหารใหม่')
            : Text('แก้ไขเมนูอาหาร'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Card(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'ชื่ออาหาร'),
                        controller: foodNameController,
                        validator: (val) {
                          if (val == null || val.length == 0) {
                            return 'กรุณากรอกชื่ออาหาร';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) =>
                            {if (_formKey.currentState!.validate()) {}},
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'คำอธิบาย'),
                        controller: foodDescController,
                        validator: (val) {
                          if (val == null || val.length == 0) {
                            return 'กรุณากรอกคำอธิบาย';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) =>
                            {_formKey.currentState!.validate()},
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
                              "ประเภทอาหาร",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Category(foodCategory, _selectedCategory,
                                  onPressedCategory)
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
                                NumberFormat('#,###')
                                        .format(_selectedCalories) +
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
                                  min: minCalories,
                                  max: maxCalories,
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
                              "รูป",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              child: _selectedImage.length != 0
                                  ? CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          FileImage(File(_selectedImage)),
                                    )
                                  : CircleAvatar(
                                      radius: 100,
                                      backgroundImage:
                                          AssetImage('assets/images/noimg.png'),
                                    ),
                              onTap: () {
                                onPickImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          submitData(context,
                              (widget.food) == null ? null : (widget.food)!.id);
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
          )),
    );
  }
}
