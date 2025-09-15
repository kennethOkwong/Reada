import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'package:reada/app/base/base_vm.dart';

// T = ViewModel type
// E = Event type
// S = ViewState's data type (e.g., List<Store>)
final getIt = GetIt.I;

class BaseView<T extends BaseViewModel<E, S>, E, S> extends StatefulWidget {
  const BaseView({
    super.key,
    required this.builder,
    this.onModelReady,
    this.onModelDispose,
    this.onEvent,
    this.viewModel,
    this.showLoadingOverlay = true,
  });

  /// Main UI builder; access view state via `model.viewState`.
  final Widget Function(BuildContext context, T model, Widget? child) builder;

  /// Called once after the model is created/resolved.
  final void Function(T model)? onModelReady;

  /// Called once when the widget is disposed (before Provider disposes model).
  final void Function(T model)? onModelDispose;

  /// One-off side effects from the model's event stream.
  final void Function(BuildContext context, T model, E event)? onEvent;

  /// Optional: inject a specific instance (else resolved via GetIt).
  final T? viewModel;

  /// Whether to show the dim overlay while `viewState.status == loading`.
  final bool showLoadingOverlay;

  @override
  State<BaseView<T, E, S>> createState() => _BaseViewState<T, E, S>();
}

class _BaseViewState<T extends BaseViewModel<E, S>, E, S>
    extends State<BaseView<T, E, S>> {
  late final T _model;
  StreamSubscription<E>? _eventSub;

  @override
  void initState() {
    super.initState();

    _model = widget.viewModel ?? getIt<T>();
    widget.onModelReady?.call(_model);

    // Listen to one-off events
    _eventSub = _model.eventStream.listen((event) {
      final handler = widget.onEvent;
      if (handler != null && mounted) {
        handler(context, _model, event);
      }
    });
  }

  @override
  void dispose() {
    _eventSub?.cancel();
    widget.onModelDispose?.call(_model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We already have an instance, so use .value
    // (If your GetIt returns factories, this is safe. If it returns singletons,
    // Provider won’t auto-dispose them—which is usually what you want.)
    return ChangeNotifierProvider<T>.value(
      value: _model,
      child: Consumer<T>(
        builder: (ctx, model, child) {
          final isLoading = widget.showLoadingOverlay &&
              model.viewState.status == ViewStatus.loading;

          return Stack(
            children: [
              widget.builder(ctx, model, child),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.3),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
