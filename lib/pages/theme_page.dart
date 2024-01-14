import 'package:catppuccin_flutter/catppuccin_flutter.dart';

import 'package:flutter/material.dart';

import "package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart";

import 'package:jupiter_frontend/jupiter_frontend.dart' as app;
import 'package:jupiter_frontend/widgets/Drawer.dart';

// TODO: define presets, currently using random colors
ThemeData latte = ThemeData(
  primaryColor: const Color(0xffe9c46a),
  colorScheme: ColorScheme(
    primary: const Color(0xffe9c46a),
    onPrimary: const Color(0xff264653),
    secondary: const Color(0xff2a9d8f),
    onSecondary: const Color(0xffe9c46a),
    background: const Color(0xffe9c46a),
    onBackground: const Color(0xff264653),
    surface: const Color(0xff264653),
    onSurface: const Color(0xffe9c46a),
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: true,
);

ThemeData frappe = ThemeData(
  primaryColor: const Color(0xff264653),
  colorScheme: ColorScheme(
    primary: const Color(0xff264653),
    onPrimary: const Color(0xffe9c46a),
    secondary: const Color(0xffe9c46a),
    onSecondary: const Color(0xff264653),
    background: const Color(0xffe9c46a),
    onBackground: const Color(0xff264653),
    surface: const Color(0xff264653),
    onSurface: const Color(0xffe9c46a),
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: true,
);

ThemeData macchiato = ThemeData(
  primaryColor: const Color(0xff2a9d8f),
  colorScheme: ColorScheme(
    primary: const Color(0xff2a9d8f),
    onPrimary: const Color(0xffe9c46a),
    secondary: const Color(0xffe9c46a),
    onSecondary: const Color(0xff2a9d8f),
    background: const Color(0xffe9c46a),
    onBackground: const Color(0xff2a9d8f),
    surface: const Color(0xff2a9d8f),
    onSurface: const Color(0xffe9c46a),
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: true,
);

ThemeData mocha = ThemeData(
  primaryColor: const Color(0xffe76f51),
  colorScheme: ColorScheme(
    primary: const Color(0xffe76f51),
    onPrimary: const Color(0xff264653),
    secondary: const Color(0xff264653),
    onSecondary: const Color(0xffe76f51),
    background: const Color(0xffe76f51),
    onBackground: const Color(0xff264653),
    surface: const Color(0xff264653),
    onSurface: const Color(0xffe76f51),
    brightness: Brightness.light,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: true,
);

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
            drawer: AppDrawer(),
            appBar: AppBar(
              title: Text("Change the Theme",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: Center(
              child: ListView(
                children: [
                  const Center(
                      child: Text("Presets",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            app.JupiterFrontendApp.getState().setTheme(latte);
                          },
                          child: const Text("Latte")),
                      TextButton(
                          onPressed: () {
                            app.JupiterFrontendApp.getState().setTheme(frappe);
                          },
                          child: const Text("Frappé")),
                      TextButton(
                          onPressed: () {
                            app.JupiterFrontendApp.getState()
                                .setTheme(macchiato);
                          },
                          child: const Text("Macchiato")),
                      TextButton(
                          onPressed: () {
                            app.JupiterFrontendApp.getState().setTheme(mocha);
                          },
                          child: const Text("Mocha")),
                    ],
                  ),
                  ...tiles
                ],
              ),
            ),
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
