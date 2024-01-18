import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/general/callisto_clickable.dart';

enum ExpandDirection {
  left,
  up,
  down,
  right
}

class CExpansionTile extends StatefulWidget {
  Widget child;
  List<Widget> expandedChildren;
  Duration duration;
  ExpandDirection expandDirection;
  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  CExpansionTile({super.key, required this.child, required this.expandedChildren, this.duration = const Duration(milliseconds: 500), this.expandDirection = ExpandDirection.down, this.mainAxisAlignment = MainAxisAlignment.start, this.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  State<CExpansionTile> createState() => _CExpansionTileState();
}

class _CExpansionTileState extends State<CExpansionTile> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    late Widget child;
    var children = [
      widget.child,
      ...widget.expandedChildren
    ];

    switch(widget.expandDirection) {
      // TODO! does this even fucking work
      case ExpandDirection.left:
        child = Row(
          // TODO! allow customization later maybe .. perhaps ...
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: _isExpanded ? children.reversed.toList() : [widget.child],
        );
        break;
      case ExpandDirection.up:
        child = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: _isExpanded ? children.reversed.toList() : [widget.child],
        );
        break;
      case ExpandDirection.down:
        child = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: _isExpanded ? children : [widget.child],
        );
        break;
      case ExpandDirection.right:
        child = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: _isExpanded ? children : [widget.child],
        );
        break;
    }

    // TODO! add smooth animation and border maybe i dont KNOW ANYMORE my t key is broken i had to type "dont" six times
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
        borderRadius: BorderRadius.circular(4)
      ),
      duration: widget.duration,
      child: CClickable(
        child: child,
        onPressed: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
      ), 
    );
  }
}