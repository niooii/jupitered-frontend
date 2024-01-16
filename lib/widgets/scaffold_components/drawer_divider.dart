import 'package:flutter/material.dart';

class CDrawerDivider extends StatelessWidget {
  const CDrawerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.5,
      color: Theme.of(context).colorScheme.onBackground
    );
  }
}