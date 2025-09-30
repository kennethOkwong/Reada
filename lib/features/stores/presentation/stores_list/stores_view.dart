import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/state_screen.dart';

class StoresView extends StatelessWidget {
  const StoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, List<String>>(
      // onModelReady: (model) => model.login(),
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case StoreEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case StoreEventType.success:
            //Handle unverified account
            if (!event.user!.isVerified) {
              final verified = await context.push<bool>(
                AppRoutes.enterCode,
                extra: vm.data.toSendCodeDto(),
              );
              if (verified != true) break;
            }

            //handle no business profile
            if (event.user!.businessProfiles.isEmpty) {
              context.mounted
                  ? context.push<bool>(AppRoutes.businessProfile)
                  : null;
              break;
            }
            context.mounted ? context.go(AppRoutes.dashboard) : null;
            break;
          default:
            break;
        }
      },
      builder: (context, vm, child) {
        return StateScreen(
          isLoading: vm.isLoading,
          hasError: vm.hasError,
          isEmpty: vm.isEmpty,
          empty: EmptyState(
            title: "No Data",
            message: "You don’t have any stores yet.\nStart by adding one!",
            buttonText: "Add store",
            onButtonPressed: () {
              // handle action
            },
          ),
          data: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => context.vSpacing16,
            itemBuilder: (context, index) {
              return Material(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: context.colorScheme.surfaceContainerHigh),
                  ),
                  child: Hero(
                    tag: 'store-$index',
                    child: Material(
                      child: ListTile(
                          title: Text(
                            'Cadenny stores',
                            style: context.textTheme.titleSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '20 Paul bassey street',
                            style: context.textTheme.labelSmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            context.push(AppRoutes.storeDetails,
                                extra: 'store');
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
