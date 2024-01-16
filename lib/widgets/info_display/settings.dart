import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CSettingsTile extends StatelessWidget {
  final Widget redirectPage;
  final Icon icon;
  final String label;

  PageRouteBuilder pageRouteBuilderWithAnim(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, a, b, c) => SharedAxisTransition(
        animation: a,
        secondaryAnimation: b,
        transitionType: SharedAxisTransitionType.horizontal,
        child: c,
      ),
    );
  }

  CSettingsTile(this.label, this.icon, this.redirectPage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.5,
            color: Theme.of(context).colorScheme.onBackground,
            style: BorderStyle.solid
          )
        ),
      ),
      child: ListTile(
        splashColor: Theme.of(context).colorScheme.error,
        leading: icon,
        title: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        onTap: () {
          Navigator.push(context, pageRouteBuilderWithAnim(redirectPage));
        },
      ),
    );
  }
}
