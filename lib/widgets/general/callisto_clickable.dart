import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CClickable extends StatelessWidget {
  Widget? child;
  void Function()? onPressed;
  
  CClickable({super.key, this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.zero,
      child: MaterialButton(
        elevation: 0,
        onPressed: onPressed,
        child: child
      ),
    );
  }
}