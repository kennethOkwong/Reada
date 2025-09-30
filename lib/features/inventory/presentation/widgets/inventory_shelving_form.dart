import 'package:flutter/material.dart';
import 'package:reada/shared/dropdown/reada_dropdown_field.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/reada_expansion_tile.dart';

class InventoryShelvingForm extends StatelessWidget {
  final String? selectedPartition;
  final String? selectedShelf;
  final ValueChanged<String?> onPartitionChanged;
  final ValueChanged<String?> onShelfChanged;

  const InventoryShelvingForm({
    super.key,
    this.selectedPartition,
    this.selectedShelf,
    required this.onPartitionChanged,
    required this.onShelfChanged,
  });

  @override
  Widget build(BuildContext context) {
    final partitions = ["Partition A", "Partition B", "Partition C"];
    final shelves = ["Shelf 1", "Shelf 2", "Shelf 3"];

    return ReadaExpansionTile(
      title: "Shelving",
      children: [
        ReadaDropdown<String>(
          title: 'Bookcase',
          hintText: 'Select bookcase',
          value: selectedPartition,
          items: partitions
              .map((p) => DropdownMenuItem(value: p, child: Text(p)))
              .toList(),
          onChanged: onPartitionChanged,
        ),
        context.vSpacing16,
        ReadaDropdown<String>(
          title: 'Shelf',
          hintText: 'Select shelf',
          value: selectedShelf,
          items: shelves
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: onShelfChanged,
        ),
      ],
    );
  }
}
