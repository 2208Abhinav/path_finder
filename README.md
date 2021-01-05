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
![DFS gif](https://raw.githubusercontent.com/2208Abhinav/path_finder/master/gifs/dfs_path_finder.gif?token=AHGPYMM4ACHO5247LXNNKCS77XYZI)

### BFS
Breadth First Search (BFS) finds the shortest valid path between two points.
![BFS gif](https://raw.githubusercontent.com/2208Abhinav/path_finder/master/gifs/bfs_path_finder.gif?token=AHGPYMJUJCFZP22TPCSALCC77XYQQ)
