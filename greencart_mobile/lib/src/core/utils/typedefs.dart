import 'package:flutter/material.dart';
import 'package:greencart_app/src/core/core.dart';

typedef TabChildrenBuilder = Widget? Function(BuildContext, int);

typedef FutureResultOf<T> = Future<Result<T, Exception>>;
typedef FutureResultListOf<T> = Future<Result<List<T>, Exception>>;
