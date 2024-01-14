// this should just be a page of statistics tbh

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:jupiter_frontend/widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: AppDrawer(),
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: const Text('Home'),
            ),
            body: const Placeholder()));
  }
}
