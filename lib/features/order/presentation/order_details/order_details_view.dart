import 'package:flutter/material.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/order/presentation/order_list/order_event.dart';
import 'package:reada/features/order/presentation/order_list/order_list_vm.dart';
import 'package:reada/shared/buttons/cutsom_button.dart';
import 'package:reada/shared/constants.dart';
import 'package:reada/shared/custom_app_bar.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';

final dummyOrder = OrderItem(
  id: "1",
  status: "Pending",
  customerName: "John Doe",
  customerEmail: "john@example.com",
  customerPhone: "+2348012345678",
  storeName: "Main Street Bookstore", // 👈 local store
  source: "via App", // 👈 for online
  date: DateTime.now(),
  total: 20000.00,
  taxes: 1000.00,
  discount: 500.00,
  items: [
    OrderLineItem(name: "Item 1", quantity: 2, price: 5000.00),
    OrderLineItem(name: "Item 2", quantity: 1, price: 10000.00),
  ],
);

class OrderLineItem {
  final String name;
  final int quantity;
  final double price;

  OrderLineItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get subtotal => quantity * price;
}

final availableStatuses = [
  "Pending",
  "Processing",
  "Shipped",
  "Delivered",
  "Cancelled"
];

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.order});
  final String order;

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewmodel, OrderEvent, void>(
      viewModel: OrderViewmodel(),
      onEvent: (context, vm, event) async {},
      builder: (context, vm, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Order #${dummyOrder.id}",
          ),
          body: Padding(
            padding: Constants.pagePadding(context),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OrderSummaryCard(vm: vm, order: dummyOrder),
                        context.vSpacing24,
                        Text('Items in Order',
                            style: context.textTheme.titleMedium),
                        context.vSpacing8,
                        ...dummyOrder.items.map(
                          (item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(item.name),
                            subtitle: Text(
                              "x${item.quantity} • ₦${item.price.toStringAsFixed(2)}",
                            ),
                            trailing: Text(
                              "₦${item.subtotal.toStringAsFixed(2)}",
                              style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Divider(height: 32),
                        _OrderTotalsSection(order: dummyOrder),
                        context.vSpacing32,
                        // Text('Customer Bids',
                        //     style: context.textTheme.titleMedium),
                        // context.vSpacing16,
                        // _BiddingSection(vm: vm, order: dummyOrder),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.vm, required this.order});
  final OrderViewmodel vm;
  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Store or Source
            Text(
              order.storeName ?? order.source ?? 'Unknown Source',
              style: context.textTheme.titleMedium,
            ),
            context.vSpacing8,

            // Customer Info (only if available)
            if (order.customerName != null) ...[
              Text("Name: ${order.customerName}",
                  style: context.textTheme.bodyMedium),
              if (order.customerEmail != null)
                Text("Email: ${order.customerEmail}",
                    style: context.textTheme.bodyMedium),
              if (order.customerPhone != null)
                Text("Phone: ${order.customerPhone}",
                    style: context.textTheme.bodyMedium),
              context.vSpacing8,
            ],

            // Status + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.dateString, style: context.textTheme.bodyMedium),
                DropdownButton<String>(
                  value: order.status,
                  items: availableStatuses
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null && val != order.status) {
                      showDialog(
                        context: context,
                        builder: (ctx) => ConfirmStatusChangeDialog(
                          oldStatus: order.status,
                          newStatus: val,
                          onConfirm: () {
                            // vm.updateStatus(val);
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderTotalsSection extends StatelessWidget {
  const _OrderTotalsSection({required this.order});
  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    final subtotal = order.items.fold<double>(
      0,
      (sum, item) => sum + item.subtotal,
    );

    final grandTotal = subtotal + order.taxes - order.discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _totalsRow(context, "Subtotal", subtotal),
        _totalsRow(context, "Taxes", order.taxes),
        if (order.discount > 0)
          _totalsRow(context, "Discount", -order.discount),
        const Divider(height: 24),
        _totalsRow(
          context,
          "Grand Total",
          grandTotal,
          isBold: true,
        ),
      ],
    );
  }

  Widget _totalsRow(BuildContext context, String label, double value,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isBold
                  ? context.textTheme.titleMedium
                  : context.textTheme.bodyMedium),
          Text(
            "₦${value.toStringAsFixed(2)}",
            style: isBold
                ? context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )
                : context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class OrderItem {
  final String id;
  final String status;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;
  final String? storeName; // for local
  final String? source; // for online
  final DateTime date;
  final double total;
  final double taxes;
  final double discount;
  final List<OrderLineItem> items;

  OrderItem({
    required this.id,
    required this.status,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.storeName,
    this.source,
    required this.date,
    required this.total,
    required this.taxes,
    required this.discount,
    required this.items,
  });

  String get dateString =>
      "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
}

class ConfirmStatusChangeDialog extends StatelessWidget {
  const ConfirmStatusChangeDialog({
    super.key,
    required this.oldStatus,
    required this.newStatus,
    required this.onConfirm,
  });

  final String oldStatus;
  final String newStatus;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        "Confirm Status Change",
        style: context.textTheme.titleMedium,
      ),
      content: Text(
        "Are you sure you want to change the order status "
        "from \"$oldStatus\" to \"$newStatus\"?",
        style: context.textTheme.bodyMedium,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      actions: [
        ReadaButton.outlined(
          title: "Cancel",
          onPressed: () => Navigator.of(context).pop(),
          borderRadius: 12,
          width: 100,
        ),
        ReadaButton.filled(
          title: "Confirm",
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          borderRadius: 12,
          width: 100,
        ),
      ],
    );
  }
}
