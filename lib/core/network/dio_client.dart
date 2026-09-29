import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jivodsr/core/config/env.dart';
import 'package:jivodsr/core/network/interceptors/error_interceptor.dart';
import 'package:jivodsr/core/network/interceptors/logging_interceptors.dart';

final dioProvider = Provider<Dio>((ref){

    final dio = Dio(
        BaseOptions(
            baseUrl:Env.baseUrl,
            connectTimeout: const Duration(seconds:15),
            receiveTimeout: const Duration(seconds:15),
            sendTimeout:const Duration(seconds:15),
            headers:{
                'Content-Type':'application/json',
                'Accept':'application/json'
            },
        ),
    );
    
    dio.interceptors.addAll([
      if (kDebugMode) LoggingInterceptors(),
    ErrorInterceptor(),
    ]);

    return dio;
    
});