import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/add_store/add_store_vm.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/helper_functions.dart';
import 'package:reada/shared/reada_expansion_tile.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddStoreView extends StatefulWidget {
  const AddStoreView({super.key});

  @override
  State<AddStoreView> createState() => _AddStoreViewState();
}

class _AddStoreViewState extends State<AddStoreView> {
  final storeNameController = TextEditingController();
  final storeAddressController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final storeDetailsController = ExpansibleController();
  final bookcaseController = ExpansibleController();

  @override
  void dispose() {
    storeNameController.dispose();
    storeAddressController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddStoreViewmodel, StoreEvent, void>(
      viewModel: AddStoreViewmodel(),
      onEvent: (context, model, event) {
        switch (event.type) {
          case StoreEventType.storeAdded:
            HelperFunctions.showSuccessToast('Store created');
            // storeDetailsController.collapse();
            // bookcaseController.expand();
            context.pop();
            break;
          case StoreEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
          default:
        }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Create store'),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// --- STEP 1: STORE DETAILS ---
                  IgnorePointer(
                      ignoring: vm.storecreated,
                      child: Opacity(
                        opacity: !vm.storecreated ? 1 : 0.5,
                        child: ReadaExpansionTile(
                          initiallyExpanded: true,
                          controller: storeDetailsController,
                          title: 'Store Details',
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  PrimaryTextField(
                                    title: 'Store name',
                                    hintText: 'Enter store name',
                                    controller: storeNameController,
                                    validator: FormValidator.validateRequired,
                                    onChanged: vm.onStoreNameChanged,
                                  ),
                                  context.vSpacing16,
                                  PrimaryTextField(
                                    title: 'Store address',
                                    hintText: 'Enter store address',
                                    validator: FormValidator.validateRequired,
                                    controller: storeAddressController,
                                    onChanged: vm.onStoreAddressChanged,
                                  ),
                                  context.vSpacing16,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: PrimaryTextField(
                                          title: 'Latitude',
                                          hintText: 'Enter latitude',
                                          controller: latitudeController,
                                          onChanged: vm.onLatitudeChanged,
                                          validator:
                                              FormValidator.validateRequired,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                      context.hSpacing16,
                                      Expanded(
                                        child: PrimaryTextField(
                                          title: 'Longitude',
                                          hintText: 'Enter longitude',
                                          controller: longitudeController,
                                          onChanged: vm.onLongitudeChanged,
                                          validator:
                                              FormValidator.validateRequired,
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  context.vSpacing24,
                                  ReadaButton.filled(
                                    width: double.infinity,
                                    title: vm.storecreated
                                        ? 'Store Added'
                                        : 'Save Store',
                                    onPressed: vm.storecreated
                                        ? () {}
                                        : () {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            vm.addStore();
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  context.vSpacing24,

                  // /// --- STEP 2: BOOKCASE SETUP ---
                  // IgnorePointer(
                  //   ignoring: !vm.storecreated,
                  //   child: Opacity(
                  //     opacity: vm.storecreated ? 1 : 0.5,
                  //     child: ReadaExpansionTile(
                  //       controller: bookcaseController,
                  //       title: '2. Add Bookcases',
                  //       actions: [
                  //         ReadaButton.icon(
                  //           icon: const Icon(Icons.add),
                  //           onPressed: vm.storecreated
                  //               ? () {
                  //                   AppBottomSheet.modalBottomSheet(
                  //                     context: context,
                  //                     title: 'Add Bookcase',
                  //                     child: const AddBookcaseBottomSheet(),
                  //                   );
                  //                 }
                  //               : () {},
                  //         ),
                  //       ],
                  //       children: [
                  //         StateScreen(
                  //           isEmpty: false,
                  //           empty: const EmptyState(
                  //             title: 'No bookcase yet',
                  //             message:
                  //                 'You have no bookcases yet.\nTap + to add one.',
                  //           ),
                  //           data: ReadaTable(
                  //             headers: const ['Case ID', 'Bookcase', 'Shelves'],
                  //             rows: [
                  //               [
                  //                 const Text('BC1-SH2'),
                  //                 const Text('Gospels'),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   crossAxisAlignment:
                  //                       CrossAxisAlignment.center,
                  //                   children: [
                  //                     const Text('14'),
                  //                     ReadaButton.icon(
                  //                       icon: const Icon(Icons.more_vert,
                  //                           color: Colors.grey),
                  //                       onPressed: () {},
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
