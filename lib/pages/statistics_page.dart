import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text("Welcome back, ...",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
            body: Placeholder()
      )
    );
  }
}