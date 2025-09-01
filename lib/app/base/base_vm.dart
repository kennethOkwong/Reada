import 'dart:async';

import 'package:flutter/material.dart';

class BaseViewModel<E, T> extends ChangeNotifier {
  ViewState<T> viewState = const ViewState.idle();
  bool get isLoading => viewState.status == ViewStatus.loading;
  bool get hasError => viewState.status == ViewStatus.error;
  bool get isEmpty => viewState.status == ViewStatus.empty;

  final StreamController<E> _eventController = StreamController<E>.broadcast();
  Stream<E> get eventStream => _eventController.stream;

  void emitEvent(E event) {
    _eventController.add(event);
  }

  // Helpers for managing viewState
  void setLoading([String? msg]) {
    viewState = ViewState.loading(msg);
    notifyListeners();
  }

  void setSuccess(T data) {
    viewState = ViewState.success(data);
    notifyListeners();
  }

  void setEmpty([String? msg]) {
    viewState = ViewState.empty(msg);
    notifyListeners();
  }

  void setError(String msg) {
    viewState = ViewState.error(msg);
    notifyListeners();
  }

  void setIdle() {
    viewState = const ViewState.idle();
    notifyListeners();
  }

  @override
  void dispose() {
    _eventController.close();
    super.dispose();
  }
}

enum ViewStatus { idle, loading, success, empty, error }

class ViewState<T> {
  final ViewStatus status;
  final T? data;
  final String? message;

  const ViewState._(this.status, {this.data, this.message});

  const ViewState.idle() : this._(ViewStatus.idle);
  const ViewState.loading([String? msg])
      : this._(ViewStatus.loading, message: msg);
  const ViewState.success(T data) : this._(ViewStatus.success, data: data);
  const ViewState.empty([String? msg]) : this._(ViewStatus.empty, message: msg);
  const ViewState.error(String msg) : this._(ViewStatus.error, message: msg);
}
