import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_finder/helpers/dimensions.dart';
import 'package:path_finder/providers/bfs_provider.dart';
import 'package:path_finder/screens/bfs/controllers.dart';
import 'package:path_finder/screens/bfs/grid.dart';
import 'package:provider/provider.dart';

class BfsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BfsScreenState();
  }
}

class _BfsScreenState extends State<BfsScreen> {
  bool bfs = false;

  bool _renderGrid = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]).then((_) {
      setState(() {
        _renderGrid = true;
      });
    });
  }

  @override
  dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BfsProvider>(
      create: (BuildContext ctx) => BfsProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.black,
          width: getViewportWidth(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _renderGrid
                  ? Expanded(child: Grid())
                  : Expanded(
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
              Controllers(),
            ],
          ),
        ),
      ),
    );
  }
}
