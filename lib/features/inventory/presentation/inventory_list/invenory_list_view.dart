import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_event.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_list_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/dropdown/reada_popup_menu.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/state_screen.dart';

class InventoryListView extends StatelessWidget {
  const InventoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<InventoryViewmodel, InventoryEvent, void>(
      viewModel: InventoryViewmodel(),
      onEvent: (context, vm, event) async {
        // switch (event.type) {
        //   case InventoryListEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case InventoryListEventType.navigateToAddInventory:
        //     context.push(AppRoutes.addInventory);
        //     break;
        //   case InventoryListEventType.navigateToEditInventory:
        //     context.push(AppRoutes.editInventory, extra: event.item);
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return StateScreen(
          isLoading: vm.isLoading,
          hasError: vm.hasError,
          isEmpty: vm.isEmpty,
          empty: EmptyState(
            title: "No Data",
            message:
                "You haven't added any inventory items yet.\nStart by adding one!",
            buttonText: "Add Item",
            onButtonPressed: () {
              // handle action
            },
          ),
          data: ListView.separated(
            separatorBuilder: (context, index) => context.vSpacing16,
            itemCount: 12,
            itemBuilder: (context, index) {
              // final item = vm.items[index];
              return InventoryCard(
                item: dummyInventory,
                onTap: () => context.push(
                  AppRoutes.updateInventory,
                  extra: 'dummyInventory',
                ),
                onUpdate: () => context.push(
                  AppRoutes.updateInventory,
                  extra: 'dummyInventory',
                ),
                onDelete: () {},
              );
            },
          ),
        );
      },
    );
  }
}

class InventoryCard extends StatelessWidget {
  const InventoryCard({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onDelete,
    required this.onTap,
  });

  final InventoryItem item;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.colorScheme.surfaceContainerHigh),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        leading: Image.network(Constants.defaultBookCover,
            width: 48, height: 48, fit: BoxFit.cover),
        title: Text(
          item.title,
          style: context.textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: '${item.author} •',
            style: context.textTheme.labelSmall,
            children: [
              TextSpan(
                text: ' ${item.quantity} in stock',
                style: context.textTheme.titleSmall?.copyWith(
                  color: item.quantity > 1 ? null : context.colorScheme.error,
                ),
              )
            ],
          ),
        ),
        trailing: ReadaPopupMenu<String>(
          onSelected: (value) {
            if (value == 'update') onUpdate();
            if (value == 'delete') onDelete();
          },
          items: const [
            PopupMenuItem(value: 'update', child: Text('Update inventory')),
            PopupMenuItem(value: 'delete', child: Text('Delete inventory')),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

final dummyInventory = InventoryItem(
  title: "The Great Gatsby",
  author: "F. Scott Fitzgerald",
  coverUrl: "https://example.com/gatsby.jpg",
  quantity: 5,
);

class InventoryItem {
  final String title;
  final String author;
  final String coverUrl;
  final int quantity;

  InventoryItem({
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.quantity,
  });
}
