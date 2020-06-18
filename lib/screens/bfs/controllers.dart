import 'package:flutter/material.dart';
import 'package:path_finder/helpers/dimensions.dart';
import 'package:path_finder/providers/bfs_provider.dart';
import 'package:provider/provider.dart';

class Controllers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BfsProvider bfsProvider = Provider.of<BfsProvider>(context);

    final double viewportWidth = getViewportWidth(context);
    final double viewportHeight = getViewportHeight(context);

    return Container(
      width: 80,
      color: Colors.lightGreen,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Colors.transparent,
              child: Text(
                'Speed',
                style: TextStyle(
                  color:
                      bfsProvider.isTraversing ? Colors.white54 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                return;
              }
              // open dialog for resizing
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  int _speed = bfsProvider.getSpeed;

                  return StatefulBuilder(
                    builder: (ctx, setState) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Container(
                          height: viewportHeight * 0.7,
                          width: viewportWidth * 0.5,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                width: viewportWidth * 0.4,
                                child: RadioListTile(
                                  value: BfsProvider.FAST,
                                  groupValue: _speed,
                                  onChanged: (int speed) {
                                    setState(() {
                                      _speed = speed;
                                    });
                                  },
                                  title: Text('Fast'),
                                ),
                              ),
                              Container(
                                width: viewportWidth * 0.4,
                                child: RadioListTile(
                                  value: BfsProvider.MEDIUM,
                                  groupValue: _speed,
                                  onChanged: (int speed) {
                                    setState(() {
                                      _speed = speed;
                                    });
                                  },
                                  title: Text('Medium'),
                                ),
                              ),
                              Container(
                                width: viewportWidth * 0.4,
                                child: RadioListTile(
                                  value: BfsProvider.SLOW,
                                  groupValue: _speed,
                                  onChanged: (int speed) {
                                    setState(() {
                                      _speed = speed;
                                    });
                                  },
                                  title: Text('Slow'),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 17,
                                    ),
                                  ),
                                  onPressed: () {
                                    bfsProvider.setSpeed = _speed;
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              color: Colors.transparent,
              child: Text(
                'Resize',
                style: TextStyle(
                  color:
                      bfsProvider.isTraversing ? Colors.white54 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                return;
              }
              // open dialog for resizing
              showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  double _rows = bfsProvider.getRows.toDouble();
                  double _cols = bfsProvider.getCols.toDouble();

                  return StatefulBuilder(
                    builder: (ctx, setState) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Container(
                          height: viewportHeight * 0.5,
                          width: viewportWidth * 0.5,
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Rows: ${_rows.toInt()}'),
                                  Container(
                                    height: 30,
                                    width: viewportWidth * 0.3,
                                    child: Slider(
                                      value: _rows,
                                      min: 5.0,
                                      max: 30.0,
                                      label: '${_rows.toInt()}',
                                      divisions: 20,
                                      activeColor: Colors.lightGreen,
                                      onChanged: (double val) {
                                        setState(() {
                                          _rows = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text('Columns: ${_cols.toInt()}'),
                                  Container(
                                    height: 30,
                                    width: viewportWidth * 0.3,
                                    child: Slider(
                                      value: _cols,
                                      min: 5.0,
                                      max: 30.0,
                                      label: '${_cols.toInt()}',
                                      divisions: 20,
                                      activeColor: Colors.lightGreen,
                                      onChanged: (double val) {
                                        setState(() {
                                          _cols = val;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                child: FlatButton(
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.lightGreen,
                                      fontSize: 17,
                                    ),
                                  ),
                                  onPressed: () {
                                    bfsProvider.resizeGrid(
                                        _rows.toInt(), _cols.toInt());
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: bfsProvider.isAddingHome
                    ? Border.all(width: 1, color: Colors.white)
                    : null,
              ),
              child: Text(
                'Home',
                style: TextStyle(
                  color:
                      bfsProvider.isTraversing ? Colors.white54 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                return;
              }
              bfsProvider.toggleAddingHomeMode();
            },
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: bfsProvider.isAddingDestination
                    ? Border.all(width: 1, color: Colors.white)
                    : null,
              ),
              child: Text(
                'Destination',
                style: TextStyle(
                  color:
                      bfsProvider.isTraversing ? Colors.white54 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                return;
              }
              bfsProvider.toggleAddingDestinationMode();
            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10),
              child: Text(
                'Reset',
                style: TextStyle(
                  color:
                      bfsProvider.isTraversing ? Colors.white54 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                return;
              }
              bfsProvider.resetGrid();
            },
          ),
          GestureDetector(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10),
              child: Text(
                bfsProvider.isTraversing ? 'Stop' : 'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              if (bfsProvider.isTraversing) {
                bfsProvider.stopTraversing();
              } else {
                bfsProvider.startBfs();
              }
            },
          ),
        ],
      ),
    );
  }
}
