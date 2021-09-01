import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:kin_a_rai_dee/model/food.dart';

import '../dbOperator.dart';
import '../randomFood.dart';
import 'about_me.dart';
import 'foodDetail.dart';
import 'food_lists.dart';

class Launcher extends StatefulWidget {
  final String title;
  const Launcher(this.title);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  final List<Food> foods = [];
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
    await insertNewFood(newFood);
    await refreshFoodList();
    // List<Food>? foods = await MyDB().getFoods();
  }

  _clearDatabase() async {
    await removeAllFood();
    await refreshFoodList();
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

  Future<void> _showConfirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยันลบเมนู'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('คุณแน่ใจว่าจะลบเมนูทั้งหมดหรือไม่?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                onPrimary: Colors.white,
              ),
              child: Text('ยืนยัน'),
              onPressed: () {
                _clearDatabase();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL!),
                  radius: 30,
                ),
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("First"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Second"),
                      value: 2,
                    )
                  ])
          // IconButton(
          //   icon: Image.network(user.photoURL!),
          //   iconSize: 50,
          //   onPressed: () {},
          // )
        ],
      ),
      body: [
        RandomFood(foods),
        FoodLists(foods, refreshFoodList),
        AboutMe()
      ][_currentTab],
      // key point, fab will show in Tab 1, and will hide in others.
      floatingActionButton: _currentTab == 1 ? groupFloating() : null,
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

  SpeedDial groupFloating() {
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
          onTap: () => _showConfirmDialog(),
        )
      ],
    );
  }
}
