import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CallistoText("IT APPEARS", size: 40),
          CallistoText("a catastrophic error has occured. ", size: 20), 
          CallistoText("restart the app.", size: 15),
          CallistoText("or don't. idk.", size: 10)
        ],
      ),
    );
  }
}