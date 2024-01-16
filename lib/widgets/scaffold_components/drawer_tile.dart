import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

class CDrawerTile extends StatelessWidget {
  final Icon icon;
  final Color splashColor;
  final Color? hoverColor;
  final Widget redirectPage;
  final String text;

  const CDrawerTile({
    super.key,
    required this.icon,
    required this.splashColor,
    this.hoverColor,
    required this.redirectPage,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: splashColor,
      hoverColor: hoverColor,
      leading: icon,
      title: CallistoText(text, size: 17),
      onTap: () {

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return redirectPage;
        }), (r) {
          return false;
        });
      },
    );
  }
}