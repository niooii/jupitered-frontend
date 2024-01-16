import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CallistoText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final double size;
  final FontWeight weight;

  const CallistoText(
    this.text, {
    required this.size,
    this.textAlign = TextAlign.left,
    this.color,
    this.weight = FontWeight.normal
    }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        color: color ?? Theme.of(context).colorScheme.onSurface,
        fontSize: size,
        fontWeight: weight
      ),
      textAlign: textAlign,
    );
  }
}