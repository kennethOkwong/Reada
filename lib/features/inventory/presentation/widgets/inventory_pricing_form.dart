import 'package:flutter/material.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/reada_expansion_tile.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/interger_increment_field.dart';

class InventoryPricingForm extends StatefulWidget {
  final TextEditingController priceController;
  final TextEditingController costPriceController;
  final int initialQuantity;
  final ValueChanged<int> onQuantityChanged;

  const InventoryPricingForm({
    super.key,
    required this.priceController,
    required this.costPriceController,
    required this.initialQuantity,
    required this.onQuantityChanged,
  });

  @override
  State<InventoryPricingForm> createState() => _InventoryPricingFormState();
}

class _InventoryPricingFormState extends State<InventoryPricingForm> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return ReadaExpansionTile(
      title: "Pricing & Stock",
      children: [
        PrimaryTextField(
          title: "Unit selling price",
          hintText: "Enter selling price",
          controller: widget.priceController,
          validator: FormValidator.validateRequired,
          keyboardType: TextInputType.number,
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: "Unit cost price",
          hintText: "Enter cost price",
          controller: widget.costPriceController,
          keyboardType: TextInputType.number,
        ),
        context.vSpacing16,
        IntegerIncrementField(
          title: 'Quantity',
          hintText: 'Enter quantity',
          value: quantity,
          min: 1,
          validator: FormValidator.validateIntegerIncrementField,
          onChanged: (val) {
            setState(() => quantity = val);
            widget.onQuantityChanged(val);
          },
        ),
      ],
    );
  }
}
