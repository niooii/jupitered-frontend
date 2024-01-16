import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/callisto_text.dart';

class CallistoDrawerOption extends StatelessWidget {
  final Icon icon;
  final Color splashColor;
  final Widget redirectPage;
  final String text;

  const CallistoDrawerOption({
    super.key,
    required this.icon,
    required this.splashColor,
    required this.redirectPage,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: splashColor,
      leading: icon,
      title: CallistoText(text, size: 17),
      onTap: () {

        if (context.widget.toStringShort() == redirectPage.toStringShort()) {
          Navigator.pop(context);
          return;
        }

        print(redirectPage.toStringShort());
        print(context.widget.toStringShort());

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