import 'package:flutter/material.dart';

import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";



class ThemePage extends StatefulWidget {
  const ThemePage({super.key});
  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Center(child: ListView(
      children: [
        ColorTile(Theme.of(context).primaryColor, "primary")
      ],



    ))));
  }
}

class ColorTile extends StatefulWidget {
  ColorTile( this.color, this.name, {super.key});
  Color color;
  String name;

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ColorPicker(
  color: widget.color,
  onChanged: (value){ },
  initialPicker: Picker.paletteHue,
), 
title: Text(widget.name)  ``,


    );
  }
}