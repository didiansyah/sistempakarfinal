import 'package:flutter/material.dart';

const double baseHeight = 100.0;

double screenAwareSize(double size, BuildContext context) {
  return size * MediaQuery.of(context).size.height / baseHeight;
}
