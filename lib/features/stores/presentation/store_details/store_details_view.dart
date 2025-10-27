import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/app/locator.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/presentation/add_bookcase/add_bookcase_bottom_sheet.dart';
import 'package:reada/features/stores/presentation/store_details/store_details_vm.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/app%20images/images.dart';
import 'package:reada/shared/bottom_sheets/app_buttom_sheets.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/state_screen.dart';

class StoreDetailsView extends StatelessWidget {
  const StoreDetailsView({super.key, required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return BaseView<StoreDetailsViewmodel, StoreEvent, void>(
      onModelReady: (model) => model.init(store),
      onModelDispose: (model) {
        locator.resetLazySingleton<StoreDetailsViewmodel>();
      },
      onEvent: (context, vm, event) async {
        // switch (event.type) {
        //   case StoreDetailsEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case StoreDetailsEventType.navigateToBookcase:
        //     context.push("${AppRoutes.bookcase}/${event.data}");
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Browse your store',
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Store Banner + Info Overlay
                Container(
                  margin: EdgeInsets.only(bottom: context.spacing24),
                  width: double.infinity,
                  height: context.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(Constants.defaultBusinessBanner),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Hero(
                      tag: store.id,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  store.name,
                                  style: context.textTheme.titleLarge?.copyWith(
                                    color: context.colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          context.vSpacing4,
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: context.colorScheme.surface,
                              ),
                              Text(
                                store.address,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorScheme.surface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                context.vSpacing24,

                /// Bookcases grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Bookcases',
                        style: context.textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: ' (${vm.bookcases.length})',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReadaButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        AppBottomSheet.modalBottomSheet(
                          context: context,
                          title: 'Add bookcase',
                          child: AddBookcaseBottomSheet(
                            storeId: vm.selectedStore.id,
                          ),
                        );
                      },
                    )
                  ],
                ),
                context.vSpacing16,
                Expanded(
                  child: SingleChildScrollView(
                    child: StateScreen(
                      isLoading: vm.isLoading,
                      hasError: vm.hasError,
                      isEmpty: vm.bookcases.isEmpty,
                      errorMessage: vm.viewState.message,
                      empty: const EmptyState(
                        title: "No Data",
                        message:
                            "You don’t have any bookcase yet.\nClick on the + icon above to add one!",
                      ),
                      data: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: vm.bookcases.length,
                        itemBuilder: (context, index) {
                          final bookcase = vm.bookcases[index];
                          return GestureDetector(
                            onTap: () => context.push(AppRoutes.shelves,
                                extra: bookcase),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: Hero(
                                        tag: 'bookcase_${bookcase.id}',
                                        child: Image.asset(
                                          AppImages.bookCase,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0)
                                        .copyWith(top: 5),
                                    child: Text(
                                      bookcase.title,
                                      style: context.textTheme.labelMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${bookcase.shelvesCount} shelves",
                                          style: context.textTheme.bodySmall,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 12,
                                          color: context
                                              .colorScheme.onSurfaceVariant,
                                        )
                                      ],
                                    ),
                                  ),
                                  context.vSpacing8,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                context.vSpacing32,
              ],
            ),
          ),
        );
      },
    );
  }
}
