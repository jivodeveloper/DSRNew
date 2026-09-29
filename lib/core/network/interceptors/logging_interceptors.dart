import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptors extends LogInterceptor {
  LoggingInterceptors()
      : super(
          requestBody: true,
          responseBody: true,
          logPrint: (object) => debugPrint(object.toString()),
        );
}
