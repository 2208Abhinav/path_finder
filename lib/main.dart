import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_finder/routes.dart';
import 'package:path_finder/screens/dfs/dfs_screen.dart';
import 'package:path_finder/screens/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.lightGreen,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // App will always remain in portrait mode
  SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(App());
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        Routes.HOME: (BuildContext ctx) => HomeScreen(),
        Routes.DFS: (BuildContext ctx) => DfsScreen(),
      },
    );
  }
}
