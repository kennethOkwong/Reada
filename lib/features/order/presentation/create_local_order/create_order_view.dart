import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/order/presentation/create_local_order/widget/add_item_to_order.dart';
import 'package:reada/features/order/presentation/order_details/order_details_view.dart';
import 'package:reada/features/order/presentation/order_list/order_event.dart';
import 'package:reada/features/order/presentation/order_list/order_list_vm.dart';
import 'package:reada/shared/bottom_sheets/app_buttom_sheets.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';

final items = [
  OrderLineItem(name: "Item A", quantity: 2, price: 5000.00),
  OrderLineItem(name: "Item B", quantity: 1, price: 10000.00),
];

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class CreateLocalOrderView extends StatelessWidget {
  const CreateLocalOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewmodel, OrderEvent, void>(
      viewModel: OrderViewmodel(),
      onEvent: (context, vm, event) async {
        // switch (event.type) {
        //   case OrderEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case OrderEventType.orderCreated:
        //     HelperFunctions.showSuccessToast(SuccessStrings.orderCreated);
        //     context.pop(); // go back to order list
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Create Local Order"),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _globalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          context.vSpacing16,
                          Text(
                            "Customer Information",
                            style: context.textTheme.titleMedium,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: "Customer Name",
                            hintText: "Enter customer name",
                            // controller: vm.customerNameController,
                            // validator: FormValidator.validateName,
                          ),
                          context.vSpacing16,
                          PrimaryTextField(
                            title: "Phone Number",
                            hintText: "Enter phone number",
                            // controller: vm.customerPhoneController,
                            keyboardType: TextInputType.phone,
                            // validator: FormValidator.validatePhone,
                          ),
                          context.vSpacing32,
                          Text(
                            "Order Items",
                            style: context.textTheme.titleMedium,
                          ),
                          context.vSpacing16,
                          ...items.map((item) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(item.name,
                                          style: context.textTheme.bodyLarge),
                                    ),
                                    Text("x${item.quantity}"),
                                    context.hSpacing16,
                                    Text("₦${item.subtotal}"),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          context.vSpacing16,
                          ReadaButton.outlined(
                            width: double.infinity,
                            title: "Add Item",
                            onPressed: () {
                              AppBottomSheet.modalBottomSheet(
                                context: context,
                                title: 'Add item to order',
                                child: const AddItemToOrderBottomSheet(),
                              );
                            },
                          ),
                          context.vSpacing32,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal",
                                  style: context.textTheme.bodyLarge),
                              Text("₦1200", style: context.textTheme.bodyLarge),
                            ],
                          ),
                          context.vSpacing8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Taxes", style: context.textTheme.bodyLarge),
                              Text("₦120", style: context.textTheme.bodyLarge),
                            ],
                          ),
                          context.vSpacing8,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Discounts",
                                  style: context.textTheme.bodyLarge),
                              Text("₦500", style: context.textTheme.bodyLarge),
                            ],
                          ),
                          const Divider(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Grand Total",
                                  style: context.textTheme.titleMedium),
                              Text("₦2600",
                                  style: context.textTheme.titleMedium),
                            ],
                          ),
                          context.vSpacing32,
                        ],
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: "Create Order",
                  borderRadius: 24,
                  onPressed: () {
                    if (!_globalKey.currentState!.validate()) return;
                    // vm.createOrder();
                  },
                ),
                context.vSpacing8,
                ReadaButton.outlined(
                  width: double.infinity,
                  title: "Cancel",
                  borderRadius: 24,
                  onPressed: () {
                    context.pop();
                  },
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
