import 'package:flutter/material.dart';

/// A reusable popup menu styled for Reada.
///
/// ## Example
/// ```dart
/// ReadaPopupMenu<String>(
///   onSelected: (value) {
///     if (value == 'update') onUpdate();
///     if (value == 'delete') onDelete();
///   },
///   items: const [
///     PopupMenuItem(value: 'update', child: Text('Update inventory')),
///     PopupMenuItem(value: 'delete', child: Text('Delete inventory')),
///   ],
/// )
/// ```
class ReadaPopupMenu<T> extends StatelessWidget {
  const ReadaPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon,
    this.tooltip,
    this.offset = const Offset(0, 40),
    this.elevation = 4,
  });

  /// Menu items to display.
  final List<PopupMenuEntry<T>> items;

  /// Callback when an item is selected.
  final void Function(T value) onSelected;

  /// The icon for the menu button (defaults to `more_vert`).
  final Widget? icon;

  /// Tooltip for accessibility.
  final String? tooltip;

  /// Offset for the popup menu.
  final Offset offset;

  /// Elevation of the popup.
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      onSelected: onSelected,
      itemBuilder: (context) => items,
      icon: icon ?? const Icon(Icons.more_vert),
      tooltip: tooltip,
      offset: offset,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
