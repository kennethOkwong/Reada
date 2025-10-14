import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reada/app/base/base_ui.dart';
import 'package:reada/features/order/presentation/order_list/order_event.dart';
import 'package:reada/features/order/presentation/order_list/order_list_vm.dart';
import 'package:reada/services/navigation%20service/app_routes.dart';
import 'package:reada/shared/dropdown/reada_dropdown_field.dart';
import 'package:reada/shared/empty_state.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'package:reada/shared/state_screen.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewmodel, OrderEvent, void>(
      viewModel: OrderViewmodel(),
      onEvent: (context, vm, event) {
        // switch (event.type) {
        //   case OrderEventType.failure:
        //     HelperFunctions.showErrorToast(event.message!);
        //     break;
        //   case OrderEventType.navigateToDetails:
        //     context.push("/orders/${event.orderId}");
        //     break;
        //   default:
        //     break;
        // }
      },
      builder: (context, vm, child) {
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              ReadaDropdown<String>(
                title: 'Viewing orders for',
                value: 'All Stores', // from state
                items: ['All Stores', 'Downtown Branch', 'Uptown Branch']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {},
              ),
              context.vSpacing16,
              const TabBar(
                tabs: [
                  Tab(text: "Local orders"),
                  Tab(text: "Online orders"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _OrderListView(
                      orders: localOrders,
                      onTap: (value) {
                        context.push(
                          AppRoutes.orderDetails,
                          extra: 'dummyOrder',
                        );
                      },
                    ),
                    _OrderListView(
                      orders: onlineOrders,
                      onTap: (value) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final localOrders = [
  OrderItem(
    id: '001',
    status: 'Completed',
    customerName: 'John Doe',
    date: DateTime.now().subtract(const Duration(days: 1)),
    total: 1500.00,
  ),
  OrderItem(
    id: '002',
    status: 'Pending',
    customerName: null,
    date: DateTime.now().subtract(const Duration(hours: 5)),
    total: 750.00,
  ),
];

final onlineOrders = [
  OrderItem(
    id: '101',
    status: 'Completed',
    customerName: 'Jane Smith',
    date: DateTime.now().subtract(const Duration(days: 2)),
    total: 2000.00,
  ),
  OrderItem(
    id: '102',
    status: 'Pending',
    customerName: 'Alice Johnson',
    date: DateTime.now().subtract(const Duration(hours: 10)),
    total: 1200.00,
  ),
];

class _OrderListView extends StatelessWidget {
  const _OrderListView({
    required this.orders,
    required this.onTap,
  });

  final List<OrderItem> orders;
  final void Function(OrderItem) onTap;

  @override
  Widget build(BuildContext context) {
    return StateScreen(
        isLoading: false,
        hasError: false,
        isEmpty: false,
        empty: EmptyState(
          title: "No Data",
          message:
              "You don’t have any orders yet.\nStart by creating a local order!",
          buttonText: "Create local order",
          onButtonPressed: () {
            // handle action
          },
        ),
        data: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = orders[index];
            return GestureDetector(
              onTap: () => onTap(order),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: context.colorScheme.surfaceContainerHigh),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "The writer in you",
                              style: context.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          context.hSpacing16,
                          Text("5 units", style: context.textTheme.titleMedium),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              order.status,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: order.status == "Completed"
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ),
                          context.hSpacing8,
                          Text(order.dateString,
                              style: context.textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

/// Example model (you probably have your own domain model)
class OrderItem {
  final String id;
  final String status;
  final String? customerName;
  final DateTime date;
  final double total;

  OrderItem({
    required this.id,
    required this.status,
    this.customerName,
    required this.date,
    required this.total,
  });

  String get dateString =>
      "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}
