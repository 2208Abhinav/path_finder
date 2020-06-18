import 'dart:collection';

import 'package:flutter/material.dart';

class BfsProvider with ChangeNotifier {
  BfsProvider() {
    _board = List(_rows);
    _visited = List(_rows);

    for (int row = 0; row < _rows; ++row) {
      _board[row] = List<int>(_cols);
      _visited[row] = List<bool>(_cols);
      for (int col = 0; col < _cols; ++col) {
        _visited[row][col] = false;
        _board[row][col] = EMPTY;
      }
    }
  }

  static const int EMPTY = 0;
  static const int WALL = 1;
  static const int HOME = 2;
  static const int DESTINATION = 3;
  static const int TILE = 4;

  static const int FAST = 0;
  static const int MEDIUM = 1;
  static const int SLOW = 2;

  List<List<int>> _board = List<List<int>>();
  List<List<bool>> _visited = List<List<bool>>();

  bool _isTraversing = false;
  bool _stopTraversing = false;

  int _homeRow = -1;
  int _homeCol = -1;
  int _destinationRow = -1;
  int _destinationCol = -1;

  int _rows = 20;
  int _cols = 20;

  bool _isAddingHome = false;
  bool _isAddingDestination = false;

  Map<int, Duration> _speeds = <int, Duration>{
    FAST: Duration(milliseconds: 30),
    MEDIUM: Duration(milliseconds: 200),
    SLOW: Duration(milliseconds: 350),
  };

  int _currentSpeed = MEDIUM;

  final List<List<int>> _steps = const [
    [-1, 0], // UP
    [0, 1], // RIGHT
    [1, 0], // DOWN
    [0, -1], // LEFT
  ];

  List<List<List<int>>> _bfsPath = List<List<List<int>>>();

  int get getRows {
    return _rows;
  }

  int get getCols {
    return _cols;
  }

  List<List<int>> get getBoard {
    return _board;
  }

  List<List<bool>> get getVisited {
    return _visited;
  }

  void resizeGrid(int rows, int cols) async {
    _isTraversing = false;
    _stopTraversing = false;
    _homeRow = -1;
    _homeCol = -1;
    _destinationRow = -1;
    _destinationCol = -1;
    _isAddingHome = false;
    _isAddingDestination = false;
    _board = List<List<int>>(0);
    _visited = List<List<bool>>(0);
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 50));

    List<List<int>> newBoard = List<List<int>>(rows);
    List<List<bool>> newVisited = List<List<bool>>(rows);
    for (int row = 0; row < rows; ++row) {
      newBoard[row] = List<int>(cols);
      newVisited[row] = List<bool>(cols);
      for (int col = 0; col < cols; ++col) {
        newVisited[row][col] = false;
        newBoard[row][col] = EMPTY;
      }
    }

    _rows = rows;
    _cols = cols;
    _board = newBoard;
    _visited = newVisited;
    notifyListeners();
  }

  void toggleWall(int row, int col) {
    _board[row][col] = _board[row][col] == 1 ? 0 : 1;
    notifyListeners();
  }

  void setHome(int row, int col) {
    // remove the old home cell
    if (_homeRow != -1 && _homeCol != -1) {
      _board[_homeRow][_homeCol] = EMPTY;
    }
    _homeRow = row;
    _homeCol = col;
    _board[row][col] = HOME;
    notifyListeners();
  }

  void setDestination(int row, int col) {
    // remove the old destination cell
    if (_destinationRow != -1 && _destinationCol != -1) {
      _board[_destinationRow][_destinationCol] = EMPTY;
    }
    _destinationRow = row;
    _destinationCol = col;
    _board[row][col] = DESTINATION;
    notifyListeners();
  }

  /// ***************** Core Algorithm for bfs *****************
  Future<bool> _bfs(int row, int col) async {
    _bfsPath = List<List<List<int>>>(_rows);
    for (int row = 0; row < _rows; ++row) {
      _bfsPath[row] = List<List<int>>(_cols);
    }

    final Queue<int> qRows = Queue<int>();
    final Queue<int> qCols = Queue<int>();

    qRows.add(row);
    qCols.add(col);
    _visited[row][col] = true;

    while (qRows.isNotEmpty && qCols.isNotEmpty) {
      int qSize = qRows.length;

      while (qSize-- > 0) {
        if (_stopTraversing) {
          notifyListeners();
          return false;
        }

        int currentRow = qRows.removeFirst();
        int currentCol = qCols.removeFirst();

        if (currentRow == _destinationRow && currentCol == _destinationCol) {
          return true;
        }

        for (final step in _steps) {
          int nextRow = currentRow + step[0];
          int nextCol = currentCol + step[1];

          if (_isValid(nextRow, nextCol)) {
            qRows.add(nextRow);
            qCols.add(nextCol);

            _bfsPath[nextRow][nextCol] = <int>[currentRow, currentCol];
            _visited[nextRow][nextCol] = true;
          }
        }
        notifyListeners();
      }

      await Future.delayed(_speeds[_currentSpeed]);
    }

    return false;
  }

  // reset visited and tiles cell
  void resetGrid() {
    // _bfsPath.clear();
    for (int row = 0; row < _rows; ++row) {
      for (int col = 0; col < _cols; ++col) {
        _visited[row][col] = false;
        if (_board[row][col] == TILE) {
          _board[row][col] = EMPTY;
        }
      }
    }
    notifyListeners();
  }

  void startBfs() async {
    if (_homeRow == -1 ||
        _homeCol == -1 ||
        _destinationRow == -1 ||
        _destinationRow == -1) return;

    _isTraversing = true;

    // reset the tiles and visited cells
    resetGrid();

    bool foundPath = await _bfs(_homeRow, _homeCol);

    // code to highlight the actual path
    if (foundPath) {
      int currentRow = _destinationRow;
      int currentCol = _destinationCol;

      // lay out the shortest path from destination to home
      List<List<int>> shortestPath = List<List<int>>();
      while (!(currentRow == _homeRow && currentCol == _homeCol)) {
        List<int> previousCell = _bfsPath[currentRow][currentCol];
        currentRow = previousCell[0];
        currentCol = previousCell[1];
        shortestPath.add(<int>[currentRow, currentCol]);
      }
      // remove the home cell because we don't want to make it tile
      shortestPath.removeLast();
      // reverse the list so that the path is from home to destination
      shortestPath = shortestPath.reversed.toList();
      // trace the path
      for (final List<int> tile in shortestPath) {
        if (_stopTraversing) {
          _stopTraversing = false;
          _isTraversing = false;
          notifyListeners();
          return;
        }
        int tileRow = tile[0];
        int tileCol = tile[1];

        if (_currentSpeed == SLOW) {
          await Future.delayed(Duration(milliseconds: 150));
        } else if (_currentSpeed == MEDIUM) {
          await Future.delayed(Duration(milliseconds: 60));
        } else {
          await Future.delayed(Duration(milliseconds: 40));
        }
        _board[tileRow][tileCol] = TILE;
        notifyListeners();
      }
    }

    _isTraversing = false;
    _stopTraversing = false;
    notifyListeners();
  }

  void stopTraversing() {
    _stopTraversing = true;
  }

  bool _isValid(int row, int col) {
    bool isNotInBounds = row < 0 || row >= _rows || col < 0 || col >= _cols;
    if (isNotInBounds || _board[row][col] == 1 || _visited[row][col])
      return false;
    return true;
  }

  void toggleAddingHomeMode() {
    _isAddingDestination = false;
    _isAddingHome = !_isAddingHome;
    notifyListeners();
  }

  bool get isAddingHome {
    return _isAddingHome;
  }

  void toggleAddingDestinationMode() {
    _isAddingHome = false;
    _isAddingDestination = !_isAddingDestination;
    notifyListeners();
  }

  bool get isAddingDestination {
    return _isAddingDestination;
  }

  bool get isTraversing {
    return _isTraversing;
  }

  int get getSpeed {
    return _currentSpeed;
  }

  set setSpeed(int speed) {
    _currentSpeed = speed;
  }
}
