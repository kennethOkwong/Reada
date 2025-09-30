import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_event.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_list_vm.dart';
import 'package:reada/features/inventory/presentation/widgets/inventory_pricing_form.dart';
import 'package:reada/features/inventory/presentation/widgets/inventory_shelving_form.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class UpdateInventoryView extends StatefulWidget {
  final String inventory;

  const UpdateInventoryView({
    super.key,
    required this.inventory,
  });

  @override
  State<UpdateInventoryView> createState() => _UpdateInventoryViewState();
}

class _UpdateInventoryViewState extends State<UpdateInventoryView> {
  late TextEditingController priceController;
  late TextEditingController costPriceController;
  late int quantity;
  String? selectedPartition;
  String? selectedShelf;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(text: 1200.toString());
    costPriceController = TextEditingController(text: 1000.toString());
    quantity = 2;
    selectedPartition = widget.inventory;
    selectedShelf = widget.inventory;
  }

  @override
  void dispose() {
    priceController.dispose();
    costPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InventoryViewmodel, InventoryEvent, void>(
      viewModel: InventoryViewmodel(),
      onEvent: (context, vm, event) {
        // handle success / error events
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Update Inventory"),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Pricing & Stock Section
                    InventoryPricingForm(
                      priceController: priceController,
                      costPriceController: costPriceController,
                      initialQuantity: 3,
                      onQuantityChanged: (val) =>
                          setState(() => quantity = val),
                    ),
                    context.vSpacing16,
                    InventoryShelvingForm(
                      selectedPartition: selectedPartition,
                      selectedShelf: selectedShelf,
                      onPartitionChanged: (val) =>
                          setState(() => selectedPartition = val),
                      onShelfChanged: (val) =>
                          setState(() => selectedShelf = val),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
