import 'package:flutter/material.dart';
import 'package:path_finder/helpers/dimensions.dart';

class Destination extends StatelessWidget {
  const Destination({
    @required this.heightFactor,
    @required this.widthFactor,
  });

  final double heightFactor;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    final double viewportHeight =
        getViewportHeight(context) + getPaddingTop(context);
    final double viewportWidth = getViewportWidth(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.white),
        color: Colors.green,
      ),
      height: viewportHeight * heightFactor,
      width: (viewportWidth - 80) * widthFactor,
    );
  }
}
