import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/domain/entities/bookcase_entity.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

class ShelvesView extends StatelessWidget {
  const ShelvesView({super.key, required this.bookcase});
  final Bookcase bookcase;

  @override
  Widget build(BuildContext context) {
    return BaseView<StoresViewmodel, StoreEvent, void>(
      viewModel: StoresViewmodel(),
      onEvent: (context, vm, event) async {
        // switch (event.type) {
        //   case ShelvesEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case ShelvesEventType.navigateToBookDetails:
        //     context.push(AppRoutes.bookDetails, extra: event.bookId);
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: bookcase.title,
            heroTag: 'bookcase_${bookcase.id}',
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: ListView.builder(
              itemCount: bookcase.shelvesCount,
              itemBuilder: (context, index) {
                // final shelf = vm.shelves[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: context.spacing24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Shelve ${index + 1}',
                          style: context.textTheme.titleMedium,
                          children: const [
                            // TextSpan(
                            //   text: ' (10 books)',
                            //   style: context.textTheme.bodyMedium?.copyWith(
                            //     color: context.colorScheme.onSurfaceVariant,
                            //     fontWeight: FontWeight.normal,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      context.vSpacing8,
                      SizedBox(
                        height: context.width * 0.55,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          separatorBuilder: (context, i) =>
                              SizedBox(width: context.spacing16),
                          itemBuilder: (context, i) {
                            // final book = shelf.books[i];
                            return GestureDetector(
                              onTap: () => context.push(AppRoutes.bookDetails,
                                  extra: 'book'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Hero(
                                      tag: 'book-$index$i',
                                      child: Container(
                                        width: context.width * 0.28,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: context.colorScheme
                                                .surfaceVariant, // fallback bg
                                            image:
                                                // book.coverUrl != null
                                                // ?
                                                DecorationImage(
                                              image: NetworkImage(
                                                  Constants.defaultBookCover),
                                              fit: BoxFit.cover,
                                            )
                                            // : null,
                                            ),
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                  ),
                                  // context.vSpacing8,
                                  SizedBox(
                                    width: context.width * 0.28,
                                    child: Text(
                                      'The writer in you, purpose and profit',
                                      style: context.textTheme.bodyMedium,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
