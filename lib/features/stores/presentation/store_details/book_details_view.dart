import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/extensions/string.dart';

class BookDetailsView extends StatelessWidget {
  final String book;

  const BookDetailsView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, void>(
      viewModel: StoresViewmodel(),
      onEvent: (context, vm, event) async {
        // switch (event.type) {
        //   case BookDetailsEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case BookDetailsEventType.addedToLibrary:
        //     HelperFunctions.showSuccessToast(SuccessStrings.addedToLibrary);
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Book details'),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumbs
                Breadcrumbs(
                  items: [
                    BreadcrumbItem(
                        label: "Cadenny Stores Cadenny Stores",
                        onTap: () => context
                          ..pop()
                          ..pop()
                          ..pop()),
                    BreadcrumbItem(
                        label: 'Bookcase 1',
                        onTap: () => context
                          ..pop()
                          ..pop()),
                    BreadcrumbItem(
                        label: 'Shelf 1', onTap: () => context.pop()),
                    BreadcrumbItem(label: 'The writer in you'), // current page
                  ],
                ),
                context.vSpacing24,

                // Book Cover Hero
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'book-00',
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                Constants.defaultBookCover,
                                width: context.width * 0.5,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: context.width * 0.7,
                                  width: context.width * 0.5,
                                  color: context.colorScheme.surfaceVariant,
                                  child: const Icon(Icons.book, size: 48),
                                ),
                              ),
                            ),
                          ),
                        ),
                        context.vSpacing24,

                        // Title & Author
                        Text(
                          'The writer in you',
                          style: context.textTheme.titleLarge,
                        ),
                        context.vSpacing8,
                        Text(
                          'Vickie Lawrence',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        context.vSpacing16,

                        // Actions
                        Row(
                          children: [
                            Expanded(
                              child: ReadaButton.filled(
                                title: 'View analytics',
                                onPressed: () {},
                                borderRadius: 24,
                              ),
                            ),
                            context.hSpacing16,
                            Expanded(
                              child: ReadaButton.outlined(
                                title: 'Add inventory',
                                onPressed: () {},
                                borderRadius: 24,
                              ),
                            ),
                            context.hSpacing16,
                            ReadaButton.icon(
                              icon: Icon(CupertinoIcons.delete,
                                  color: context.colorScheme.error),
                              onPressed: () {},
                            ),
                          ],
                        ),

                        context.vSpacing24,

                        // Metadata
                        Text(
                          'Book Details',
                          style: context.textTheme.titleMedium,
                        ),
                        context.vSpacing8,
                        _DetailRow(
                            label: 'Publisher', value: 'Unknown Publisher'),
                        _DetailRow(label: 'Year', value: '2023'),
                        _DetailRow(label: 'Pages', value: '300'),
                        context.vSpacing24,

                        // Description
                        Text(
                          'Description',
                          style: context.textTheme.titleMedium,
                        ),
                        context.vSpacing8,
                        Text(
                          'Book description goes here. This is a placeholder for the book description. It can be quite long, so we will implement a show more/less functionality to handle lengthy descriptions gracefully within the UI.',
                          style: context.textTheme.bodyLarge,
                        ),
                        context.vSpacing32,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const _DetailRow({required this.label, this.value});

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

class Breadcrumbs extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const Breadcrumbs({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < items.length; i++) ...[
          GestureDetector(
              onTap: items[i].onTap,
              child: Text(
                items[i].label.shortenText(),
                style: context.textTheme.bodySmall?.copyWith(
                  color: i == items.length - 1
                      ? context.colorScheme.onSurface
                      : context.colorScheme.primary,
                  fontWeight: i == items.length - 1
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              )),
          if (i < items.length - 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.spacing4),
              child: Icon(Icons.chevron_right,
                  size: 14, color: context.colorScheme.onSurfaceVariant),
            ),
        ]
      ],
    );
  }
}

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.label, this.onTap});
}
