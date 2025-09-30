import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/stores/presentation/add_store/widgets/add_bookcase_bottom_sheet.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_event.dart';
import 'package:reada/features/stores/presentation/stores_list/stores_vm.dart';
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
import 'package:reada/shared/state_screen.dart';
import 'package:reada/shared/tables/reada_table.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
    return BaseView<StoresViewmodel, StoreEvent, List<String>>(
      onEvent: (context, vm, event) async {
        switch (event.type) {
          case StoreEventType.failure:
            HelperFunctions.showErrorToast(event.message!);
            break;
          case StoreEventType.success:
            if (!event.user!.isVerified) {
              final verified = await context.push<bool>(
                AppRoutes.enterCode,
                extra: vm.data.toSendCodeDto(),
              );
              if (verified != true) break;
            }
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
                  Form(
                    key: _globalKey,
                    child: ReadaExpansionTile(
                      initiallyExpanded: true,
                      title: "Store details",
                      children: [
                        PrimaryTextField(
                          title: 'Store name',
                          hintText: 'Enter store name',
                          controller: storeNameController,
                          validator: FormValidator.validateRequired,
                          // onChanged: vm.onStoreNameChanged,
                          keyboardType: TextInputType.text,
                        ),
                        context.vSpacing16,
                        PrimaryTextField(
                          title: 'Store address',
                          hintText: 'Enter store address',
                          controller: storeAddressController,
                          // onChanged: vm.onStoreAddressChanged,
                          keyboardType: TextInputType.text,
                        ),
                        context.vSpacing16,
                        Row(
                          children: [
                            Expanded(
                              child: PrimaryTextField(
                                title: 'Latitude',
                                hintText: 'Enter store latitude',
                                controller: latitudeController,
                                // onChanged: vm.onLatitudeChanged,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            context.hSpacing16,
                            Expanded(
                              child: PrimaryTextField(
                                title: 'Longitude',
                                hintText: 'Enter store longitude',
                                controller: longitudeController,
                                // onChanged: vm.onLongitudeChanged,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        context.vSpacing20,
                        ReadaButton.filled(
                          width: double.infinity,
                          title: 'Add store',
                          onPressed: () {
                            if (!_globalKey.currentState!.validate()) {
                              return;
                            }
                            // vm.addStore();
                          },
                        ),
                      ],
                    ),
                  ),
                  context.vSpacing32,
                  ReadaExpansionTile(
                    title: "Bookcases",
                    actions: [
                      ReadaButton.icon(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          AppBottomSheet.modalBottomSheet(
                            context: context,
                            title: 'Add bookcase',
                            child: const AddBookcaseBottomSheet(),
                          );
                        },
                      ),
                    ],
                    children: [
                      StateScreen(
                        isEmpty: false,
                        empty: const EmptyState(
                          title: 'No book case',
                          message:
                              'You have no bookcase yet.\nClick on + icon to add one',
                        ),
                        data: ReadaTable(
                          headers: const ['Case Id', "Bookcase", "Shelves"],
                          rows: [
                            [
                              const Text("BC1-SH2"),
                              const Text("Gospels"),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text("14"),
                                  ReadaButton.icon(
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.grey),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
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
