abstract class Result<T> {
  const Result();

  R when<R>({
    required R Function(T? data) success,
    required R Function(String message) failure,
  });

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

class Success<T> extends Result<T> {
  final T? data; // ✅ T is now nullable

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
    return failure(error ?? 'An error occured');
  }
}
