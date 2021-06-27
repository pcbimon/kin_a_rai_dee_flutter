import 'package:flutter/material.dart';

class category extends StatelessWidget {
  final List<String> items;
  final int selectedCategory;
  final Function selectHandler;
  category(this.items, this.selectedCategory,this.selectHandler);
  List<Widget> _createCategories(List<String> cats, int selectedIndex,BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < cats.length; i++) {
      bool selected = selectedIndex == i ? true : false;
      list.add(new GestureDetector(
        child: Stack(alignment: Alignment.topRight, children: [
          Card(
            shape: selected
                ? new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0))
                : new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0)),
            child: Container(margin: EdgeInsets.all(30), child: Text(cats[i])),
          ),
          Container(
            child: Row(
              children: [
                selected ? Icon(Icons.check_circle_rounded,color: Theme.of(context).primaryColor) : SizedBox()
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          )
        ]),
        onTap: (){
          selectHandler(i);
        },
      )
      );
    }
    return list;
  }

  Widget build(BuildContext context) {
    return Row(
      children: _createCategories(items, selectedCategory,context),
    );
  }
}
