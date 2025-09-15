import 'package:reada/services/api%20service/error_handling/exceptions.dart';

abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T? data, String? message) success,
    required R Function(ReadaException exception) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  /// ✅ Transform the success value (like Either.map)
  Result<R> map<R>(R Function(T data) transform) {
    if (this is Success<T>) {
      final success = this as Success<T>;
      final data = success.data;
      if (data == null) {
        return Failure<R>(const ReadaUnknownException());
      }
      return Success<R>(
        data: transform(data),
        message: success.message,
      );
    } else if (this is Failure<T>) {
      final failure = this as Failure<T>;
      return Failure<R>(failure.exception);
    }
    return Failure<R>(const ReadaUnknownException());
  }

  /// ✅ Transform the failure (like Either.mapLeft)
  Result<T> mapFailure(
    ReadaException Function(ReadaException exception) transform,
  ) {
    if (this is Failure<T>) {
      final failure = this as Failure<T>;
      return Failure<T>(transform(failure.exception));
    }
    return this;
  }
}

class Success<T> extends Result<T> {
  final T? data;
  final String? message;

  const Success({this.data, this.message});

  @override
  R when<R>({
    required R Function(T? data, String? message) success,
    required R Function(ReadaException exception) failure,
  }) {
    return success(data, message);
  }
}

class Failure<T> extends Result<T> {
  final ReadaException exception;

  const Failure(this.exception);

  @override
  R when<R>({
    required R Function(T? data, String? message) success,
    required R Function(ReadaException exception) failure,
  }) {
    return failure(exception);
  }
}
