sealed class Result<T> {
  const Result();

  static Result<T> success<T>(T value) => Success(value);
  static Result<T> failure<T>(Object error, [StackTrace? stackTrace]) => Failure(error, stackTrace);
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final Object error;
  final StackTrace? stackTrace;
  const Failure(this.error, [this.stackTrace]);
}

extension ResultX<T> on Result<T> {
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        _ => null,
      };

  Object? get errorOrNull => switch (this) {
        Failure<T>(:final error) => error,
        _ => null,
      };
}