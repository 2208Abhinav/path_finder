import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_finder/helpers/dimensions.dart';
import 'package:path_finder/providers/bfs_provider.dart';
import 'package:path_finder/widgets/cell.dart';
import 'package:path_finder/widgets/destination.dart';
import 'package:path_finder/widgets/home.dart';
import 'package:path_finder/widgets/path_tile.dart';
import 'package:path_finder/widgets/wall.dart';
import 'package:provider/provider.dart';

class Grid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridState();
  }
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    final BfsProvider bfsProvider = Provider.of<BfsProvider>(context);

    final List<List<int>> _board = bfsProvider.getBoard;
    final List<List<bool>> _visited = bfsProvider.getVisited;
    final int _rows = bfsProvider.getRows;
    final int _cols = bfsProvider.getCols;

    return IgnorePointer(
      ignoring: bfsProvider.isTraversing,
      child: Container(
        height: getViewportHeight(context) + getPaddingTop(context),
        width: getViewportWidth(context) - 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _board
              .asMap()
              .map(
                (int rowIndex, List<int> row) {
                  return MapEntry(
                    rowIndex,
                    Container(
                      width: getViewportWidth(context) - 80,
                      height: (getViewportHeight(context) +
                              getPaddingTop(context)) /
                          _rows,
                      child: Row(
                        children: row
                            .asMap()
                            .map(
                              (int colIndex, int cellValue) {
                                if (cellValue == BfsProvider.EMPTY) {
                                  return MapEntry(
                                    colIndex,
                                    GestureDetector(
                                      child: Cell(
                                        heightFactor: 1 / _rows,
                                        widthFactor: 1 / _cols,
                                        isVisited: _visited[rowIndex][colIndex],
                                      ),
                                      onTap: () {
                                        if (bfsProvider.isAddingHome) {
                                          bfsProvider.setHome(
                                              rowIndex, colIndex);
                                        } else if (bfsProvider
                                            .isAddingDestination) {
                                          bfsProvider.setDestination(
                                              rowIndex, colIndex);
                                        } else {
                                          bfsProvider.toggleWall(
                                            rowIndex,
                                            colIndex,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                } else if (cellValue == BfsProvider.HOME) {
                                  return MapEntry(
                                    colIndex,
                                    GestureDetector(
                                      child: Home(
                                        heightFactor: 1 / _rows,
                                        widthFactor: 1 / _cols,
                                      ),
                                    ),
                                  );
                                } else if (cellValue ==
                                    BfsProvider.DESTINATION) {
                                  return MapEntry(
                                    colIndex,
                                    GestureDetector(
                                      child: Destination(
                                        heightFactor: 1 / _rows,
                                        widthFactor: 1 / _cols,
                                      ),
                                    ),
                                  );
                                } else if (cellValue == BfsProvider.TILE) {
                                  return MapEntry(
                                    colIndex,
                                    PathTile(
                                      heightFactor: 1 / _rows,
                                      widthFactor: 1 / _cols,
                                    ),
                                  );
                                }

                                return MapEntry(
                                  colIndex,
                                  GestureDetector(
                                    child: Wall(
                                      heightFactor: 1 / _rows,
                                      widthFactor: 1 / _cols,
                                    ),
                                    onTap: () => bfsProvider.toggleWall(
                                        rowIndex, colIndex),
                                  ),
                                );
                              },
                            )
                            .values
                            .toList(),
                      ),
                    ),
                  );
                },
              )
              .values
              .toList(),
        ),
      ),
    );
  }
}
