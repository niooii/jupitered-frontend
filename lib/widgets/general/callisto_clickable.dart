import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CClickable extends StatelessWidget {
  Widget? child;
  double elevation;
  void Function()? onPressed;
  
  CClickable({super.key, this.child, this.onPressed, this.elevation=0});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.zero,
      child: MaterialButton(
        splashColor: Colors.transparent,
        elevation: elevation,
        onPressed: onPressed,
        child: child
      ),
    );
  }
}