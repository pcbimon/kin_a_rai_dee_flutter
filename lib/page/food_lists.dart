import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kin_a_rai_dee/model/food.dart';
import 'package:kin_a_rai_dee/widget/slidable_widget.dart';

import '../dbOperator.dart';
import '../utils.dart';

class FoodLists extends StatefulWidget {
  final List<Food> foods;
  final Function refreshFoodList;
  const FoodLists(this.foods, this.refreshFoodList);

  @override
  _FoodListsState createState() => _FoodListsState(foods);
}

class _FoodListsState extends State<FoodLists> {
  List<Food> items;
  _FoodListsState(this.items);
  // List<Food> items = [
  //   new Food('foodName', 'foodCategory', 500, 'nationality', 'description',
  //       'assets/images/food1.jpg'),
  //   new Food('foodName', 'foodCategory', 500, 'nationality', 'description',
  //       'assets/images/food2.jpg')
  // ];

  @override
  initState() {
    super.initState();
  }

  updateFoodList() async {
    setState(() {
      items = widget.foods;
    });
    Utils.showSnackBar(context, "Update Foods");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final item = items[index];
            return SlidableWidget(
              child: buildListTile(item),
              onDismissed: (action) =>
                  dismissSlidableItem(context, index, action),
              key: null,
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: items.length),
    );
  }

  void dismissSlidableItem(
      BuildContext context, int index, SlidableAction action) {
    switch (action) {
      case SlidableAction.update:
        Utils.showSnackBar(context, 'Update Data');
        break;
      case SlidableAction.delete:
        Utils.showSnackBar(context, 'Food will deleted');
        break;
    }
  }

  Widget buildListTile(Food item) => ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: AssetImage(item.img),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.foodName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(item.foodCategory)
          ],
        ),
        onTap: () {},
      );
}
