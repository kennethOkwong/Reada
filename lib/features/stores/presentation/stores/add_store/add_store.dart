import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/stores/stores_event.dart';
import 'package:reada/features/stores/presentation/stores/stores_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/bottom_sheets/app_buttom_sheets.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/reada_expansion_tile.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

class AddStoreView extends StatelessWidget {
  const AddStoreView({super.key});

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
        return Scaffold(
          appBar: const CustomAppBar(
            title: 'Add store',
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReadaExpansionTile(
                    initiallyExpanded: true,
                    title: "Store details",
                    children: [
                      PrimaryTextField(
                        title: 'Store name',
                        hintText: 'Enter store name',
                        // controller: emailTextController,
                        onChanged: vm.onEmailChanged,
                        validator: FormValidator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      context.vSpacing16,
                      PrimaryTextField(
                        title: 'Store address',
                        hintText: 'Enter store address',
                        // controller: emailTextController,
                        onChanged: vm.onEmailChanged,
                        validator: FormValidator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      context.vSpacing16,
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryTextField(
                              title: 'Latitude',
                              hintText: 'Enter store latitude',
                              // controller: emailTextController,
                              onChanged: vm.onEmailChanged,
                              validator: FormValidator.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          context.hSpacing16,
                          Expanded(
                            child: PrimaryTextField(
                              title: 'Longitude',
                              hintText: 'Enter store longitude',
                              // controller: emailTextController,
                              onChanged: vm.onEmailChanged,
                              validator: FormValidator.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ],
                      ),
                      context.vSpacing32,
                      ReadaButton.filled(
                          width: double.infinity,
                          title: 'Add store',
                          onPressed: () {})
                    ],
                  ),
                  context.vSpacing32,
                  ReadaExpansionTile(
                    title: "Bookcases",
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          AppBottomSheet.show(
                            context: context,
                            title: 'Add bookcase',
                            child: ReadaTable(
                              headers: ['Id', "Bookcase", "Shelves"],
                              rows: [
                                [
                                  const Text("BC1-SH2"),
                                  const Text("Gospels"),
                                  const Text("14"),
                                  IconButton(
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.grey),
                                    onPressed: () {},
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      )
                    ],
                    children: [
                      EmptyState(
                          title: 'No book case',
                          message:
                              'You have no bookcase yet.\nClick on + icon to add one'),

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: PrimaryTextField(
                      //         title: 'Bookcase name',
                      //         hintText: 'Shelve name (E.g Shelve 1)',
                      //         // controller: emailTextController,
                      //         onChanged: vm.onEmailChanged,
                      //         validator: FormValidator.validateEmail,
                      //         keyboardType: TextInputType.emailAddress,
                      //       ),
                      //     ),
                      //     context.hSpacing16,
                      //     Expanded(
                      //       child: PrimaryTextField(
                      //         title: 'No of shelves',
                      //         hintText: 'Shelve partition (E.g Partition 1)',
                      //         // controller: emailTextController,
                      //         onChanged: vm.onEmailChanged,
                      //         validator: FormValidator.validateEmail,
                      //         keyboardType: TextInputType.emailAddress,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // ReadaTable(
                      //   headers: ['Id', "Bookcase", "Shelves"],
                      //   rows: [
                      //     [
                      //       const Text("BC1-SH2"),
                      //       const Text("Gospels"),
                      //       const Text("14"),
                      //       IconButton(
                      //         icon: const Icon(Icons.more_vert,
                      //             color: Colors.grey),
                      //         onPressed: () {},
                      //       ),
                      //     ],
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReadaTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final TextStyle? headerStyle;
  final double rowHeight;

  const ReadaTable({
    super.key,
    required this.headers,
    required this.rows,
    this.headerStyle,
    this.rowHeight = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // Headers
          // Container(
          //   height: rowHeight,
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade200,
          //     borderRadius:
          //         const BorderRadius.vertical(top: Radius.circular(12)),
          //   ),
          //   child: Row(
          //     children: headers
          //         .map(
          //           (h) => Expanded(
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: Text(
          //                 h,
          //                 style: headerStyle ??
          //                     const TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black87,
          //                     ),
          //               ),
          //             ),
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
          // Rows
          ...rows.map(
            (r) => Container(
              height: rowHeight,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: r
                    .map(
                      (c) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: c,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
