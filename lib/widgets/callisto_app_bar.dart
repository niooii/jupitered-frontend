import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jupiter_frontend/widgets/callisto_text.dart';

class CallistoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  @override
  final preferredSize = const Size.fromHeight(kToolbarHeight);

  const CallistoAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: CallistoText(title, size: 30),
      actions: [
        Icon(Icons.info_outline),
        Gap(15),
        Icon(Icons.message),
        Gap(15)
      ],
    );
  }
}