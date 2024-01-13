import 'package:flutter/material.dart';

import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";

import 'package:jupiter_frontend/jupiter_frontend.dart' as app;

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});
  static ThemeData getTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  List<ColorTile> tiles = [];

  ThemeData newTheme(List<ColorTile> tiles) {
    return ThemeData(
      primaryColor: tiles[0].color,
      colorScheme: ColorScheme(
        primary: tiles[0].color,
        onPrimary: tiles[1].color,
        secondary: tiles[2].color,
        onSecondary: tiles[3].color,
        background: tiles[4].color,
        onBackground: tiles[5].color,
        surface: tiles[6].color,
        onSurface: tiles[7].color,
        brightness: Brightness.light,
        error: Colors.red,
        onError: Colors.white,
      ),
      useMaterial3: true,
    );
  }

  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Map<String, Color> schemeColors = {
      "primary": colorScheme.primary,
      "onPrimary": colorScheme.onPrimary,
      "secondary": colorScheme.secondary,
      "onSecondary": colorScheme.onSecondary,
      "background": colorScheme.background,
      "onBackground": colorScheme.onBackground,
      "surface": colorScheme.surface,
      "onSurface": colorScheme.onSurface,
    };
    List<ColorTile> tiles =
        schemeColors.entries.map((e) => ColorTile(e.value, e.key)).toList();

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Change the theme"),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Center(
                child: ListView(
              children: [...tiles],
            )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                app.JupiterFrontendApp.getState().setTheme(newTheme(tiles));
                // Navigator.pop(context);
              },
              child: Icon(Icons.check),
            )));
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
            content: SingleChildScrollView(
              child: Container(
                  height: 400,
                  width: 400,
                  child: ColorPicker(
                    color: widget.color,
                    onChanged: (value) {
                      widget.color = value;
                      setState(() {});
                    },
                    initialPicker: Picker.wheel,
                  )),
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
      leading: GestureDetector(
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.grey, width: 1.75, style: BorderStyle.solid),
          ),
        ),
        onTap: () {
          _showDialog(context);
        },
      ),
      title: Text(widget.name),
    );
  }
}
