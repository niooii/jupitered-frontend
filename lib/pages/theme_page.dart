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
    ThemeData theme = ThemePage.getTheme(context);
    print(theme.toString());
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: ListView(

      children: [ColorTile(Theme.of(context).primaryColor, "primary")],
    ))));
  }
}

class ColorTile extends StatefulWidget {
  ColorTile(this.color, this.name, {super.key});
  Color color;
  String name;

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {

  _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Pick a color"),
            content: ColorPicker(
              color: widget.color,
              onChanged: (value) {
                widget.color = value;
                setState(() {
                  
                });
              },
              initialPicker: Picker.paletteHue,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Done"))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(child:
       Container(
        width: 30,
        height: 30,
        color: widget.color,
      ), onTap: () {
        _showDialog(context);
      },),
      title: Text(widget.name),
    );
  }
}
