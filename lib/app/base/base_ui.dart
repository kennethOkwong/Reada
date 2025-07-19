import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reada/shared/extensions/build_context_extension.dart';
import 'base_vm.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.I;

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({
    super.key,
    this.builder,
    this.onModelReady,
    this.onModelDispose,
    this.color = Colors.white,
  });

  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onModelDispose;
  final Color color;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = getIt<T>();

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
  }

  @override
  void dispose() {
    if (widget.onModelDispose != null) {
      widget.onModelDispose!(model);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => model,
      child: Consumer<T>(
        builder: (_, model, __) => Stack(
          children: [
            widget.builder!.call(_, model, __),
            if (model.isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                width: double.infinity,
                height: context.height,
                child: Center(
                  child: Column(
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
