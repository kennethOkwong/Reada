import 'package:flutter/material.dart';
import 'package:reada/shared/empty_state.dart';

/// Reusable stateful screen wrapper
class StateScreen extends StatelessWidget {
  final Widget? data;
  final Widget? empty;
  final Widget? error;
  final bool isLoading;
  final bool hasError;
  final bool isEmpty;
  final String? errorMessage;

  const StateScreen({
    super.key,
    required this.data,
    this.empty,
    this.error,
    this.isLoading = false,
    this.hasError = false,
    this.isEmpty = false,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return error ??
          EmptyState(
            isError: true,
            title: "No data found",
            message: errorMessage ?? "Unable to fetch data",
          );
    }

    if (isEmpty) {
      return empty ??
          const EmptyState(
            title: "No data available",
            message: "You don’t have any item yet.",
          );
    }

    return data ?? const SizedBox.shrink();
  }
}
