import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kin_a_rai_dee/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleProfile extends StatelessWidget {
  const GoogleProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'Name : ' + user.displayName!,
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
                  Text(user.email!),
                ],
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
