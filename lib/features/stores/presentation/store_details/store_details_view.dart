import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/domain/entities/store_entity.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/app%20images/images.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class StoreDetailsView extends StatelessWidget {
  const StoreDetailsView({super.key, required this.store});

  final Store store;

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, List<Store>>(
      viewModel: StoresViewmodel(),
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
                      tag: 'store-0',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Cadenny Book Stores',
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
                                '123 Nwaniba Road, Uyo',
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
                Text.rich(
                  TextSpan(
                    text: 'Bookcases',
                    style: context.textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' (10)',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                context.vSpacing16,
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        // final bookcase = vm.bookcases[index];
                        return GestureDetector(
                          onTap: () => context.push(AppRoutes.shelves,
                              extra: 'bookcase'),
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
                                      tag: 'bookcase-$index',
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
                                    'Bookcase ${index + 1}',
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
                                        "2 shelves",
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
                context.vSpacing32,
              ],
            ),
          ),
        );
      },
    );
  }
}
