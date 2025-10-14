import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/features/stores/presentation/add_store/add_store_vm.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/interger_increment_field.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class AddBookcaseBottomSheet extends StatelessWidget {
  const AddBookcaseBottomSheet({
    super.key,
    required this.vm,
  });

  final AddStoreViewmodel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Form(
        key: _globalKey,
        child: Column(
          children: [
            PrimaryTextField(
              title: 'Bookcase title',
              hintText: 'Enter bookcase title',
              validator: FormValidator.validateRequired,
              onChanged: vm.onBookcaseTitleChanged,
              keyboardType: TextInputType.text,
            ),
            context.vSpacing16,
            IntegerIncrementField(
              title: 'No of shelves',
              hintText: 'Enter number of shelves',
              value: 1,
              min: 10,
              max: 100,
              validator: FormValidator.validateIntegerIncrementField,
              onChanged: vm.onNoOfShelvesChanged,
            ),
            context.vSpacing20,
            ReadaButton.filled(
              width: double.infinity,
              title: 'Add bookcase',
              onPressed: () {
                if (!_globalKey.currentState!.validate()) {
                  return;
                }
                vm.addBookcase();
              },
            ),
            context.vSpacing20,
          ],
        ),
      ),
    );
  }
}
