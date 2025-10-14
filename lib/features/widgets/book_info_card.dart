import 'package:flutter/material.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class BookInfoCard extends StatelessWidget {
  final String book;

  const BookInfoCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('The writer in you', style: context.textTheme.titleLarge),
        context.vSpacing8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                Constants.defaultBookCover,
                width: context.width * 0.35,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: context.width * 0.5,
                  width: context.width * 0.35,
                  color: context.colorScheme.surfaceVariant,
                  child: const Icon(Icons.book, size: 48),
                ),
              ),
            ),
            context.hSpacing16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.vSpacing16,

                  /// Metadata
                  Text('Book Details', style: context.textTheme.titleMedium),
                  context.vSpacing8,
                  const DetailRow(label: 'Author', value: 'Vickie Lawrence'),
                  const DetailRow(
                      label: 'Publisher', value: 'Unknown Publisher'),
                  const DetailRow(label: 'Year', value: '2023'),
                  const DetailRow(label: 'Pages', value: '300'),
                  const DetailRow(label: 'Store', value: 'Cadenny Stores'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const DetailRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: context.spacing8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "$label:",
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value!, style: context.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
