import 'package:flutter/material.dart';
import 'package:path_finder/helpers/dimensions.dart';

class Cell extends StatelessWidget {
  const Cell({
    @required this.heightFactor,
    @required this.widthFactor,
    @required this.isVisited,
  });

  final bool isVisited;
  final double heightFactor;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final double viewportHeight =
        getViewportHeight(context) + getPaddingTop(context);
    final double viewportWidth = getViewportWidth(context);

    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: isVisited ? Colors.blueAccent : Colors.transparent,
      ),
      height: viewportHeight * heightFactor ,
      width: (viewportWidth - 80) * widthFactor,
    );
  }
}
