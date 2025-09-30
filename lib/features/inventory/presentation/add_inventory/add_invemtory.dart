import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_event.dart';
import 'package:reada/features/inventory/presentation/inventory_list/inventory_list_vm.dart';
import 'package:reada/features/inventory/presentation/widgets/inventory_pricing_form.dart';
import 'package:reada/features/inventory/presentation/widgets/inventory_shelving_form.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/form_validator.dart';
import 'package:reada/shared/state_screen.dart';
import 'package:reada/shared/text%20fields/custom_text_field.dart';
import 'package:reada/shared/text%20fields/interger_increment_field.dart';
import 'package:reada/shared/reada_expansion_tile.dart';

final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

class AddInventoryView extends StatefulWidget {
  const AddInventoryView({super.key});

  @override
  State<AddInventoryView> createState() => _AddInventoryViewState();
}

class _AddInventoryViewState extends State<AddInventoryView> {
  int currentStep = 0;

  void onNextStep() {
    if (currentStep < 1) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  void onPreviousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep -= 1;
      });
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InventoryViewmodel, InventoryEvent, void>(
      viewModel: InventoryViewmodel(),
      onEvent: (context, vm, event) async {
        // Handle events here
      },
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Add Inventory",
            actions: [
              Padding(
                padding: Constants.pagePadding(context),
                child: Text("${currentStep + 1}/2"),
              ),
            ],
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _globalKey,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: currentStep == 0
                            ? _SelectBookStep(
                                key: const ValueKey(0),
                                vm: vm,
                              )
                            : _PricingStockShelvingStep(
                                key: const ValueKey(1),
                                vm: vm,
                              ),
                      ),
                    ),
                  ),
                ),
                ReadaButton.filled(
                  width: double.infinity,
                  title: currentStep == 1 ? "Save Item" : "Next",
                  borderRadius: 24,
                  onPressed: () {
                    if (!_globalKey.currentState!.validate()) return;
                    if (currentStep == 0) {
                      onNextStep();
                      return;
                    }
                    context.pop();
                    // vm.saveInventory();
                  },
                ),
                context.vSpacing8,
                ReadaButton.outlined(
                  width: double.infinity,
                  title: "Back",
                  borderRadius: 24,
                  onPressed: onPreviousStep,
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

class _BookTile extends StatelessWidget {
  const _BookTile({
    super.key,
    required this.book,
    this.onTap,
    this.isSelected = false,
  });

  final String book;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        Constants.defaultBookCover,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
      ),
      title: const Text('The writer in you'),
      subtitle: const Text('Vickie Lawerence'),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: context.colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}

/// STEP 1: Search & Select Book
class _SelectBookStep extends StatefulWidget {
  const _SelectBookStep({super.key, required this.vm});
  final InventoryViewmodel vm;

  @override
  State<_SelectBookStep> createState() => _SelectBookStepState();
}

class _SelectBookStepState extends State<_SelectBookStep> {
  final searchController = TextEditingController();
  List<String> searchResults = [];
  String selectedBookId = '';
  bool isSearching = false;

  void onBookSelected(String bookId) {
    searchController.clear();
    searchResults.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      selectedBookId = bookId;
    });
  }

  void onSearchChanged(String? query) {
    isSearching = query?.isNotEmpty ?? false;
    if (isSearching) {
      setState(() {
        searchResults.add(query!);
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isSearching = false;
        });
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: selectedBookId.isNotEmpty,
          child: _BookTile(
            book: selectedBookId,
            isSelected: true,
          ),
        ),
        context.vSpacing16,
        PrimaryTextField(
          title: "Search book",
          hintText: "Enter book title or author",
          onChanged: onSearchChanged,
          controller: searchController,
          validator: FormValidator.validateRequired,
        ),
        context.vSpacing16,
        Visibility(
          visible: selectedBookId.isEmpty || searchController.text.isNotEmpty,
          child: StateScreen(
            isLoading: isSearching,
            isEmpty: searchResults.isEmpty,
            empty: const EmptyState(
              title: "No results",
              message: "Try a different keyword",
            ),
            data: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final book = searchResults[index];
                return _BookTile(
                  isSelected: false,
                  book: book,
                  onTap: () {
                    onBookSelected(book);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// STEP 2: Pricing, Stock & Shelving (combined with ReadaExpansionTile)
class _PricingStockShelvingStep extends StatefulWidget {
  const _PricingStockShelvingStep({super.key, required this.vm});
  final InventoryViewmodel vm;

  @override
  State<_PricingStockShelvingStep> createState() =>
      _PricingStockShelvingStepState();
}

class _PricingStockShelvingStepState extends State<_PricingStockShelvingStep> {
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final costPriceController = TextEditingController();
  String? selectedPartition;
  String? selectedShelf;

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    costPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final partitions = ["Partition A", "Partition B", "Partition C"];
    final shelves = ["Shelf 1", "Shelf 2", "Shelf 3"];

    return Column(
      children: [
        context.vSpacing16,
        InventoryPricingForm(
          priceController: priceController,
          costPriceController: costPriceController,
          initialQuantity: 1,
          onQuantityChanged: (val) {
            // store in vm or state
          },
        ),
        context.vSpacing16,
        InventoryShelvingForm(
          selectedPartition: selectedPartition,
          selectedShelf: selectedShelf,
          onPartitionChanged: (val) => setState(() => selectedPartition = val),
          onShelfChanged: (val) => setState(() => selectedShelf = val),
        ),
        context.vSpacing32,
      ],
    );
  }
}
