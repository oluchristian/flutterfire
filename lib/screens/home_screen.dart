import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.logout),
            label: Text('sign out'),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),
    );
  }
}
