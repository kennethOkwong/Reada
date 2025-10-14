import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/state_screen.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, List<Store>>(
      onModelReady: (model) => model.getStores(),
      builder: (context, vm, child) {
        return StateScreen(
          isLoading: vm.isLoading,
          hasError: vm.hasError,
          isEmpty: vm.isEmpty,
          errorMessage: vm.viewState.message,
          empty: EmptyState(
            title: "No Data",
            message: "You don’t have any stores yet.\nStart by adding one!",
            buttonText: "Add store",
            onButtonPressed: () {
              context.push(AppRoutes.addStore);
            },
          ),
          data: ListView.separated(
            itemCount: vm.stores.length,
            separatorBuilder: (context, index) => context.vSpacing16,
            itemBuilder: (context, index) {
              final store = vm.stores[index];
              return Material(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: context.colorScheme.surfaceContainerHigh),
                  ),
                  child: Hero(
                    tag: store.id,
                    child: Material(
                      child: ListTile(
                          title: Text(
                            store.name,
                            style: context.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            store.address,
                            style: context.textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            context.push(AppRoutes.storeDetails, extra: store);
                          }),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
