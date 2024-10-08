import 'package:flutter/material.dart';

//extension of Differennt objects

// extention on number to pass sizedbox of passed num
extension EmptySpace on num {
  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}

// extension on buildcontext to return  size

extension ScreenSizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
