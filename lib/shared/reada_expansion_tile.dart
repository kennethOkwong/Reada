import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class ReadaExpansionTile extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final IconData expandedIcon;
  final IconData collapsedIcon;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final List<Widget> actions; // ✅ new

  const ReadaExpansionTile({
    Key? key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.expandedIcon = Icons.keyboard_arrow_up,
    this.collapsedIcon = Icons.keyboard_arrow_down,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.actions = const [], // ✅ default empty
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: backgroundColor ?? Colors.white,
          collapsedBackgroundColor: collapsedBackgroundColor,
          initiallyExpanded: initiallyExpanded,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          childrenPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),

          // ✅ Custom trailing with actions + expand/collapse icon
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...actions, // your custom widgets (buttons/icons etc.)
              context.hSpacing8,
              _ExpansionIcon(
                expandedIcon: expandedIcon,
                collapsedIcon: collapsedIcon,
              ),
            ],
          ),

          children: children,
        ),
      ),
    );
  }
}

/// 🔧 Custom expansion icon widget (to mimic ExpansionTile default)
class _ExpansionIcon extends StatefulWidget {
  final IconData expandedIcon;
  final IconData collapsedIcon;

  const _ExpansionIcon({
    required this.expandedIcon,
    required this.collapsedIcon,
  });

  @override
  State<_ExpansionIcon> createState() => _ExpansionIconState();
}

class _ExpansionIconState extends State<_ExpansionIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(Tween<double>(begin: 0, end: 0.5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ExpansionTile provides an ExpansionTileController via InheritedWidget
    final expansionTile = ExpansionTileController.of(context);
    final isExpanded = expansionTile?.isExpanded ?? false;

    if (isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return RotationTransition(
      turns: _iconTurns,
      child: Icon(
        isExpanded ? widget.expandedIcon : widget.collapsedIcon,
      ),
    );
  }
}
