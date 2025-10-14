import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/features/widgets/book_info_card.dart';
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
        // Handle events if needed
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Book details'),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Breadcrumbs
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
                    BreadcrumbItem(label: 'The writer in you'),
                  ],
                ),
                context.vSpacing24,

                /// Book Cover + Info
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BookInfoCard(
                          book: 'dummyBook',
                        ),
                        context.vSpacing16,

                        /// Actions
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
                              icon: Icon(
                                CupertinoIcons.delete,
                                color: context.colorScheme.error,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        context.vSpacing24,

                        /// Metadata
                        Text('Shelving Info',
                            style: context.textTheme.titleMedium),
                        context.vSpacing8,
                        const DetailRow(
                            label: 'Store', value: 'Cadenny Stores'),
                        const DetailRow(label: 'Bookcase', value: 'Bookcase 1'),
                        const DetailRow(label: 'Shelf', value: 'Shelf 1'),

                        context.vSpacing24,

                        /// Description
                        Text('Description',
                            style: context.textTheme.titleMedium),
                        context.vSpacing8,
                        Text(
                            'This is a placeholder for the book description. It can be quite long, so we will implement a show more/less functionality to handle lengthy descriptions gracefully within the UI.',
                            style: context.textTheme.bodyLarge),
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

/// -----------------
/// Breadcrumbs
/// -----------------
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
