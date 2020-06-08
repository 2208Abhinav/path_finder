import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_finder/helpers/dimensions.dart';
import 'package:path_finder/providers/dfs_provider.dart';
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
    final DfsProvider dfsProvider = Provider.of<DfsProvider>(context);

    final List<List<int>> _board = dfsProvider.getBoard;
    final List<List<bool>> _visited = dfsProvider.getVisited;
    final int _rows = dfsProvider.getRows;
    final int _cols = dfsProvider.getCols;

    return IgnorePointer(
      ignoring: dfsProvider.isTraversing,
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
                                if (cellValue == DfsProvider.EMPTY) {
                                  return MapEntry(
                                    colIndex,
                                    GestureDetector(
                                      child: Cell(
                                        heightFactor: 1 / _rows,
                                        widthFactor: 1 / _cols,
                                        isVisited: _visited[rowIndex][colIndex],
                                      ),
                                      onTap: () {
                                        if (dfsProvider.isAddingHome) {
                                          dfsProvider.setHome(
                                              rowIndex, colIndex);
                                        } else if (dfsProvider
                                            .isAddingDestination) {
                                          dfsProvider.setDestination(
                                              rowIndex, colIndex);
                                        } else {
                                          dfsProvider.toggleWall(
                                            rowIndex,
                                            colIndex,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                } else if (cellValue == DfsProvider.HOME) {
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
                                    DfsProvider.DESTINATION) {
                                  return MapEntry(
                                    colIndex,
                                    GestureDetector(
                                      child: Destination(
                                        heightFactor: 1 / _rows,
                                        widthFactor: 1 / _cols,
                                      ),
                                    ),
                                  );
                                } else if (cellValue == DfsProvider.TILE) {
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
                                    onTap: () => dfsProvider.toggleWall(
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
