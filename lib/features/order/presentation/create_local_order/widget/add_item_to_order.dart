import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class AddItemToOrderBottomSheet extends StatefulWidget {
  const AddItemToOrderBottomSheet({super.key});

  @override
  State<AddItemToOrderBottomSheet> createState() =>
      _AddItemToOrderBottomSheetState();
}

class _AddItemToOrderBottomSheetState extends State<AddItemToOrderBottomSheet> {
  String _query = '';
  String? _selectedItem;

  final List<String> _inventory = [
    "Book A",
    "Book B",
    "Book C",
    "Stationery Pack"
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _inventory
        .where((item) => item.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 👈 important for bottom sheets
        children: [
          PrimaryTextField(
            title: 'Search inventory',
            hintText: 'Type product name...',
            // validator: FormValidator.validateRequired,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _query = value;
              });
            },
          ),
          context.vSpacing16,
          if (filtered.isEmpty)
            Center(
              child: Text(
                'No items found',
                style: context.textTheme.bodyMedium,
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true, // 👈 allow inside scroll
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return ListTile(
                  title: Text(item),
                  trailing: _selectedItem == item
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedItem = item;
                    });
                  },
                );
              },
            ),
          context.vSpacing20,
          ReadaButton.filled(
            width: double.infinity,
            title: 'Add Item',
            onPressed: () {
              if (_selectedItem == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please select an item')),
                );
                return;
              }
              context.pop(_selectedItem);
            },
          ),
          context.vSpacing20,
        ],
      ),
    );
  }
}
