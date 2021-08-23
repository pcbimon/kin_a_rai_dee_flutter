import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/page/food_lists.dart';
import 'package:kin_a_rai_dee/randomFood.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_store/json_store.dart';

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
  int _currentTab = 0;
  final dbHelper = DatabaseHelper.instance;
  Future<void> _addNewFood() async {
    var getAll = await dbHelper.queryAllRows();
    String foodNameIndex = getAll.length.toString();
    Food food = new Food('Food$foodNameIndex', 'Cat1', 500, 'Thai', '123',
        'assets/images/food1.jpg');
    Food newFood = await dbHelper.insert(food);

    print(getAll.length);
    FoodLists().createState().initState();
    // List<Food>? foods = await MyDB().getFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: [RandomFood(), FoodLists(), RandomFood()][_currentTab],
      // key point, fab will show in Tab 1, and will hide in others.
      floatingActionButton: _currentTab == 1
          ? FloatingActionButton(
              onPressed: () {
                _addNewFood();
              },
              child: Icon(Icons.add),
            )
          : null,
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
}
