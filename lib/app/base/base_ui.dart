import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'base_vm.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

class BaseView<T extends BaseViewModel<E>, E> extends StatefulWidget {
  const BaseView({
    super.key,
    this.builder,
    this.onModelReady,
    this.onModelDispose,
    this.onEvent,
    this.viewModel,
  });

  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onModelDispose;
  final void Function(BuildContext context, T model, E event)? onEvent;
  final T? viewModel;

  @override
  State<BaseView<T, E>> createState() => _BaseViewState<T, E>();
}

class _BaseViewState<T extends BaseViewModel<E>, E>
    extends State<BaseView<T, E>> {
  late T model;

  late StreamSubscription<E> _eventSubscription;

  @override
  void initState() {
    super.initState();
    model = widget.viewModel ?? getIt<T>();
    widget.onModelReady?.call(model);

    _eventSubscription = model.eventStream.listen((event) {
      widget.onEvent?.call(context, model, event);
    });
  }

  @override
  void dispose() {
    _eventSubscription.cancel();
    widget.onModelDispose?.call(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.viewModel ?? model,
      child: Consumer<T>(
        builder: (_, model, __) => Stack(
          children: [
            widget.builder!.call(_, model, __),
            if (model.isLoading)
              Container(
                color: Colors.black.withValues(alpha: 0.3),
                width: double.infinity,
                height: context.height,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      Text(model.loadingText),
                    ],
                  ),
                ),
              )
            // ShimmerUser()
          ],
        ),
      ),
    );
  }
}
