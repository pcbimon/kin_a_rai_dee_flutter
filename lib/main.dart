import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/page/about_me.dart';
import 'package:kin_a_rai_dee/page/food_lists.dart';
import 'package:kin_a_rai_dee/page/foodDetail.dart';
import 'package:kin_a_rai_dee/randomFood.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kin_a_rai_dee/utils.dart';

import 'dbOperator.dart';
import 'model/food.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme)),
      home: MyHomePage(title: 'กินอะไรดี'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Food> foods = [];
  final _random = new Random();
  @override
  initState() {
    refreshFoodList();
    super.initState();
  }

  int _currentTab = 0;

  final dbHelper = DatabaseHelper.instance;
  navigateNewFood() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodDetail(_addNewFood),
        ));
  }

  Future<void> _addNewFood(Food newFood) async {
    // String foodNameIndex = foods.length.toString();
    await dbHelper.insert(newFood);
    await refreshFoodList();
    // List<Food>? foods = await MyDB().getFoods();
  }

  _clearDatabase() async {
    await dbHelper.removeAllFood();
    refreshFoodList();
  }

  refreshFoodList() async {
    var getAll = await selectAllFood();
    setState(() {
      foods.clear();
      getAll.forEach((food) {
        foods.add(food);
      });
      print('Current Food : ${foods.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: [
        RandomFood(foods),
        FoodLists(foods, refreshFoodList),
        AboutMe()
      ][_currentTab],
      // key point, fab will show in Tab 1, and will hide in others.
      floatingActionButton: _currentTab == 1 ? GroupFloating() : null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) => {setState(() => _currentTab = index)},
        currentIndex: _currentTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Database',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'About ME',
          ),
        ],
      ),
    );
  }

  SpeedDial GroupFloating() {
    return SpeedDial(
      icon: Icons.menu,
      activeIcon: Icons.close,
      spacing: 3,
      buttonSize: 56,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onTap: () => navigateNewFood(),
        ),
        SpeedDialChild(
          child: Icon(Icons.remove_circle_outline),
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          onTap: () => _clearDatabase(),
        )
      ],
    );
  }
}
