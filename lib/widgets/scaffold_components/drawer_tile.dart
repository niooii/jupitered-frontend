import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

class CDrawerTile extends StatelessWidget {
  final Icon icon;
  final Color splashColor;
  final Color? hoverColor;
  final Widget redirectPage;
  final String text;
  // if not, then u can press back etc
  final bool isCorePage;
  Function? onTapCallback;

  CDrawerTile({
    super.key,
    required this.icon,
    required this.splashColor,
    this.hoverColor,
    required this.redirectPage,
    required this.text,
    this.isCorePage = true,
    this.onTapCallback
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: splashColor,
      hoverColor: hoverColor,
      leading: icon,
      title: CallistoText(text, size: 17),
      onTap: () {
        if(onTapCallback != null) {
          onTapCallback!();
        }
        if(isCorePage) {
          Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return redirectPage;
          }), (r) {
            return false;
          });
        } else {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return redirectPage;
          }));
        }
      },
    );
  }
}