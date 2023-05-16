# Path Finder

A mobile application (Android and iOS) to visualize DFS and BFS path finding algorithms.

### Build the apk:
- First make sure that you have installed all the necessary packages by running the following command:
```sh
$ flutter pub get
```
- Run the following command to build the apk of the application.
```sh
$ flutter build apk
```
The apk can be found at `build/app/outputs/flutter-apk/app-release.apk`

### DFS
Depth First Search (DFS) just finds a valid path between two points. There is no check on the length of the path. The path (if found) can be absurdly long or can be the shortest.

![dfs_path_finder](https://github.com/2208Abhinav/path_finder/assets/30211121/561b244a-2178-4fcf-8fdb-894cf62771e5)

### BFS
Breadth First Search (BFS) finds the shortest valid path between two points.

![bfs_path_finder gif](https://github.com/2208Abhinav/path_finder/assets/30211121/8b06f707-586f-48f5-8235-1e01315e964a)
