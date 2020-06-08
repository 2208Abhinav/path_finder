import 'package:flutter/material.dart';

double getViewportHeight(BuildContext context) {
  final MediaQueryData mediaQueryData = MediaQuery.of(context);

  return mediaQueryData.size.height -
      (mediaQueryData.padding.top + mediaQueryData.padding.bottom);
}

double getViewportWidth(BuildContext context) {
  final MediaQueryData mediaQueryData = MediaQuery.of(context);

  return mediaQueryData.size.width -
      (mediaQueryData.padding.left + mediaQueryData.padding.right);
}

double getPaddingTop(BuildContext context) {
  final MediaQueryData mediaQueryData = MediaQuery.of(context);

  return mediaQueryData.padding.top;
}

double getPaddingBottom(BuildContext context) {
  final MediaQueryData mediaQueryData = MediaQuery.of(context);

  return mediaQueryData.padding.bottom;
}
