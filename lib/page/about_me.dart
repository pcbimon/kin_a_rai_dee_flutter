import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            child: CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              'Patipat Chewprecha',
              style: TextStyle(fontSize: 30, color: Colors.teal),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  color: Colors.lightGreen,
                ),
                Text('patipat.che@mahidol.ac.th'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
