import 'package:flutter/material.dart';
import 'package:path_finder/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Path Finder',
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(10),
          crossAxisSpacing: 5,
          children: <Widget>[
            GestureDetector(
              child: Card(
                child: Center(
                  child: Text(
                    'DFS',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                elevation: 5,
              ),
              onTap: () => Navigator.of(context).pushNamed(Routes.DFS),
            ),
          ],
        ),
      ),
    );
  }
}
