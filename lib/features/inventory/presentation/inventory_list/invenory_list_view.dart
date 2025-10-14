import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_event.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_list_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/dropdown/reada_dropdown_field.dart';
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
          data: Column(
            children: [
              ReadaDropdown<String>(
                title: 'Viewing inventory for',
                value: 'All Stores', // from state
                items: ['All Stores', 'Downtown Branch', 'Uptown Branch']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {},
              ),
              context.vSpacing16,
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => context.vSpacing16,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    // final item = vm.items[index];
                    return InventoryCard(
                      item: 'dummyInventory',
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
              ),
            ],
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

  final String item;
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
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(Constants.defaultBookCover,
              width: 48, height: 48, fit: BoxFit.cover),
        ),
        title: Text(
          'The writer in you',
          style: context.textTheme.titleSmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            text: 'Cadenny Stores •',
            style: context.textTheme.labelSmall,
            children: [
              TextSpan(
                text: ' 5 in stock',
                style: context.textTheme.titleSmall?.copyWith(
                  color: 2 > 1 ? null : context.colorScheme.error,
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
