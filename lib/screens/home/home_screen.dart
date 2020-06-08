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
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(15),
          crossAxisSpacing: 5,
          children: <Widget>[
            GestureDetector(
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        color: Colors.lightGreen,
                        child: Text(
                          'DFS',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Depth First Search (DFS) just finds a valid path between two points. '
                        'There is no check on the length of the path. The path (if found) can be '
                        'absurdly long or can be the shortest.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
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
