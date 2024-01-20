import 'package:flutter/material.dart';

class CDivider extends StatelessWidget {
  const CDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.5,
      color: Theme.of(context).colorScheme.onBackground
    );
  }
}