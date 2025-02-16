import 'dart:async';

import 'package:dio/dio.dart';
import 'package:greencart_app/src/core/core.dart';

/// This class will be used by class users in their methods.
///
/// A base class `Result` with two implementations — Success and Failure.
/// When you need to return a value from a function that
/// potentially can throw an Exception or may return an unexpected result,
/// you should use Result as a return value, like this:
///
/// {@template divideFunction}
/// ```dart
/// Result<int, String> divide(int a, int b) {
///  if (b == 0) {
///    return failure('Cannot divide by zero');
///  }
///  return success(a ~/ b);
/// }
/// ```
/// {@endtemplate}
sealed class Result<S, F> {
  const Result._();

  /// Returns true if the result is [Success]
  /// {@macro divideFunction}
  /// ```dart
  ///  return success(a ~/ b);
  /// }
  /// final result = divide(2, 1); // returns success(2)
  /// print(result.isSuccess); // prints true
  /// ```
  bool get isSuccess => this is Success<S, F>;

  /// Returns true if the result is [Failure]
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(2, 0); // returns failure('Cannot divide by zero')
  /// print(result.isFailure); // prints true
  /// ```
  bool get isFailure => this is Failure<S, F>;

  /// `fold` takes two functions as parameters: one for handling a success value and one for handling an error value.
  /// It applies the appropriate function based on whether the Result represents a success or an error.
  /// {@macro divideFunction}
  /// ```dart
  /// final value = divide(2, 1).fold(
  ///  (r) => r, // returns the result if division succeeded
  ///  (e) => double.negativeInfinity, // returns negative inf if division failed
  ///);
  /// ```
  B fold<B>(B Function(S s) ifSuccess, B Function(F f) ifFailure);

  /// Get [success] value. May throw an exception when the value is [failure]
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(2, 1);
  /// print(result.successValue); // prints 2
  /// ```
  S get successValue => this.fold<S>(
    (s) => s,
    (f) =>
        throw Exception(
          'Illegal use. You should check isSuccess before calling',
        ),
  );

  /// Get [failure] value. May throw an exception when the value is [success]
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(2, 0);
  /// print(result.falureValue); // throws an exception
  /// ```
  F get failureValue => this.fold<F>(
    (s) =>
        throw Exception(
          'Illegal use. You should check isFailure before calling',
        ),
    (f) => f,
  );

  /// This function applies a transformation to the success value of a Result,
  /// and returns a new Result that contains the transformed value. If the original Result
  /// represents an error, the transformation is not applied and
  /// the error is propagated to the new Result.
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(4, 2).map((r) => r * 2);
  /// print(result.successValue); // prints 4
  /// ```
  Result<S2, F> map<S2>(S2 Function(S s) f) =>
      fold((S s) => success(f(s)), failure);

  /// Similar to map, but the transformation function returns a Result
  /// rather than a raw value. This is useful when the transformation itself can fail.
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(4, 2).flatMap((r) => divide(r, 0));
  /// print(result.falureValue); // prints 'Cannot divide by zero'
  /// ```
  Result<S2, F> flatMap<S2>(Result<S2, F> Function(S s) f) => fold(f, failure);

  /// An asynchronous version of flatMap.
  /// The transformation function is asynchronous (returns a Future<Result>) and
  /// so is asyncFlatMap itself.
  /// ```dart
  /// final userCredential = await Result.fromAsync(() => firebaseAuth.signInWithProvider(provider));
  /// final result = userCredential.asyncFlatMap(
  ///  (s) async {
  /// final payload = LoginPayload(
  /// email: s.user?.email ?? '',
  /// name: s.user?.displayName ?? '',
  /// );
  /// final response = await Result.fromAsync(() => authClient.login(payload: payload));
  ///  return response;
  ///},
  /// );
  ///  return result;
  /// ```
  Future<Result<S2, F>> asyncFlatMap<S2>(
    Future<Result<S2, F>> Function(S s) f,
  ) => fold(f, (error) => Future.value(failure(error)));

  /// Similar to map, but doesn't return a new Result. Instead, it simply applies
  /// a function for its side effects and returns nothing. If the Result is an error,
  /// the function is not applied.
  /// {@macro divideFunction}
  /// ```dart
  /// divide(4, 2).forEach((r) => print(r)); // prints 2
  /// ```
  FutureOr<void> forEach<T>(FutureOr<T> Function(S) f) => fold(f, (_) {});

  /// Returns the success value if the Result represents a success, and defaultValue's
  /// result if it represents an error.
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(4, 2).getOrElse(() => 0);
  /// print(result); // prints 2
  /// ```
  S getOrElse(S Function() defaultValue) =>
      fold((s) => s, (_) => defaultValue());

  /// Returns the success value if the Result represents a success, and null
  /// if it represents an error.
  /// {@macro divideFunction}
  /// ```dart
  /// final result = divide(4, 2).getOrNull();
  /// print(result); // prints 2
  /// ```
  S? getOrNull() => fold((s) => s, (_) => null);

  /// Constructs a Result from a Future. If the Future completes successfully,
  /// the Result is a success with the value of the Future. If the Future fails,
  /// the Result is an error with the error of the Future.
  /// ```dart
  /// Future<Result<UserModel, Exception>> _login({required LoginPayload payload}) async {
  /// final response =
  ///    await Result.fromAsync(() => authClient.login(payload: payload));
  ///  final result = response.map((s) => s.data!);
  /// return result;
  ///}
  /// ```
  static Future<Result<T, Exception>> fromAsync<T>(
    Future<T> Function() func,
  ) async {
    try {
      final result = await func();
      return success(result);
    } on DioException catch (exception) {
      switch (exception.type) {
        case DioExceptionType.badResponse:
          final error = AppException.fromErrorResponse(exception.response!);
          return failure(error);
        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
          return failure(
            const ClientException(
              message:
                  'Error establishing a connection to the server. Please try again.',
            ),
          );
        case _:
          return failure(ClientException(message: exception.toString()));
      }
    } on Exception catch (e) {
      return failure(ClientException(message: e.toString()));
    } on Error catch (e) {
      return failure(Exception('${e.runtimeType}: ${e.stackTrace}'));
    }
  }

  ///  Constructs a Result by running a function. If the function returns normally,
  /// the Result is a success with the return value of the function. If the function
  /// throws an exception, the Result is an error with the thrown exception.
  /// ```dart
  /// final result = Result.fromAction(() => 2);
  /// print(result.successValue); // prints 2
  /// ```
  static Result<T, Exception> fromAction<T>(T Function() func) {
    try {
      final result = func();
      return success(result);
    } on Exception catch (e) {
      return failure(e);
      // ignore: avoid_catching_errors
    } on Error catch (e) {
      return failure(Exception('${e.runtimeType}: ${e.stackTrace}'));
    }
  }

  /// Constructs a Result from a value that may be null. If the value is non-null,
  /// the Result is a success with that value. If the value is null, the Result
  /// is an error.
  /// ```dart
  /// final result = Result.fromNullable(2, () => Exception('Value is null'));
  /// print(result.successValue); // prints 2
  /// ```
  static Result<T, Exception> fromNullable<T>(
    T? value,
    Exception Function() onError,
  ) {
    if (value != null) {
      return success(value);
    } else {
      return failure(onError());
    }
  }

  /// Constructs a Result by testing a condition. If the condition is true,
  /// the Result is a success with a certain value. If the condition is false,
  /// the Result is an error with a certain error.
  /// ```dart
  /// final result = Result.fromPredicate(2 > 1, () => 2, () => Exception('Condition is false'));
  /// print(result.successValue); // prints 2
  /// ```
  static Result<T, Exception> fromPredicate<T>(
    bool condition,
    T Function() onSuccess,
    Exception Function() onError,
  ) => condition ? success(onSuccess()) : failure(onError());
}

/// A container for Failure values
class Failure<S, F> extends Result<S, F> {
  const Failure._(this._f) : super._();

  final F _f;

  /// Returns the failure value
  /// ```dart
  /// final result = failure('Something went wrong');
  /// print(result.value); // prints 'Something went wrong'
  /// ```
  F get value => _f;

  @override
  B fold<B>(B Function(S s) ifSuccess, B Function(F f) ifFailure) =>
      ifFailure(_f);

  @override
  bool operator ==(Object other) => other is Failure && other._f == _f;

  @override
  int get hashCode => _f.hashCode;
}

/// A container for Success values
class Success<S, F> extends Result<S, F> {
  const Success._(this._s) : super._();

  final S _s;

  /// Returns the success value
  /// ```dart
  /// final result = success(2);
  /// print(result.value); // prints 2
  /// ```
  S get value => _s;

  @override
  B fold<B>(B Function(S s) ifSuccess, B Function(F f) ifFailure) =>
      ifSuccess(_s);

  @override
  bool operator ==(Object other) => other is Success && other._s == _s;

  @override
  int get hashCode => _s.hashCode;
}

/// Helper function to create a [Failure]
/// ```dart
/// final result = failure('Something went wrong');
/// print(result.isFailure); // prints true
/// ```
Result<S, F> failure<S, F>(F f) => Failure._(f);

/// Helper function to create a [Success]
/// ```dart
/// final result = success(2);
/// print(result.isSuccess); // prints true
/// ```
Result<S, F> success<S, F>(S s) => Success._(s);
