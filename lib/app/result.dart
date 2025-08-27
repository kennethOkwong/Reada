import 'package:reada/shared/constants.dart';

abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T? data) success,
    required R Function(String message) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  /// ✅ Transform the success value (like Either.map)
  Result<R> map<R>(R Function(T data) transform) {
    if (this is Success<T>) {
      final data = (this as Success<T>).data;
      if (data == null) {
        return Failure<R>(Constants.genericError);
      }
      return Success<R>(transform(data));
    } else if (this is Failure<T>) {
      return Failure<R>((this as Failure<T>).error);
    }
    return Failure<R>(Constants.genericError);
  }

  /// ✅ Transform the failure message (like Either.mapLeft)
  Result<T> mapFailure(String Function(String message) transform) {
    if (this is Failure<T>) {
      final error = (this as Failure<T>).error ?? Constants.genericError;
      return Failure<T>(transform(error));
    }
    return this;
  }
}

class Success<T> extends Result<T> {
  final T? data;

  const Success([this.data]);

  @override
  R when<R>({
    required R Function(T? data) success,
    required R Function(String message) failure,
  }) {
    return success(data);
  }
}

class Failure<T> extends Result<T> {
  final String? error;

  const Failure([this.error]);

  @override
  R when<R>({
    required R Function(T? data) success,
    required R Function(String message) failure,
  }) {
    return failure(error ?? Constants.genericError);
  }
}
