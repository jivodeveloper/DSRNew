import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jivodsr/app.dart';
import 'package:jivodsr/core/error/app_exception.dart';
import 'package:jivodsr/core/network/dio_client.dart';
import 'package:jivodsr/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:jivodsr/features/auth/data/repositories/auth_repository_impl.dart';

const loginResponse = <String, dynamic>{
  'personID': 100,
  'personType': 'PROMOTER(GT)',
  'EmployeeID': null,
  'personName': 'Rekha rani ',
  'userName': 'Rekharani',
  'password': null,
  'contactNo': null,
  'email': null,
  'weekOff': null,
};

Dio fakeApi(Object? data, {void Function(RequestOptions)? onRequest}) {
  final dio = Dio();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        onRequest?.call(options);
        handler.resolve(Response(requestOptions: options, data: data));
      },
    ),
  );
  return dio;
}

void main() {
  test(
    'login sends API parameters and stores the returned user until logout',
    () async {
      final dio = fakeApi(
        loginResponse,
        onRequest: (options) {
          expect(options.method, 'POST');
          expect(options.path, '/AndroidServer/LoginSalesPerson3');
          expect(options.queryParameters, {
            'user': 'Rekharani',
            'password': 'test-password',
          });
        },
      );
      addTearDown(dio.close);
      final repository = AuthRepositoryImpl(AuthRemoteDatasource(dio));
      expect(await repository.hasSession(), isFalse);
      final user = await repository.login(
        username: 'Rekharani',
        password: 'test-password',
      );
      expect(user.id, 100);
      expect(user.name, 'Rekha rani');
      expect(user.type, 'PROMOTER(GT)');
      expect(user.username, 'Rekharani');
      expect(await repository.hasSession(), isTrue);
      await repository.logout();
      expect(await repository.hasSession(), isFalse);
    },
  );

  for (final response in [
    null,
    <String, dynamic>{},
    {'personID': 0},
    {'personID': -1},
  ]) {
    test('rejects unsuccessful login response: $response', () async {
      final dio = fakeApi(response);
      addTearDown(dio.close);
      final repository = AuthRepositoryImpl(AuthRemoteDatasource(dio));
      await expectLater(
        repository.login(username: 'test', password: 'test'),
        throwsA(isA<InvalidCredentialsException>()),
      );
      expect(await repository.hasSession(), isFalse);
    });
  }

  test('malformed user data produces a displayable error', () async {
    final dio = fakeApi({'personID': 'invalid'});
    addTearDown(dio.close);
    await expectLater(
      AuthRemoteDatasource(dio).login(username: 'test', password: 'test'),
      throwsA(isA<UnknownException>()),
    );
  });

  testWidgets('successful login opens dashboard', (tester) async {
    final dio = fakeApi(loginResponse);
    addTearDown(dio.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Rekharani');
    await tester.enterText(find.byType(TextFormField).at(1), 'test-password');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Here is your daily sales overview.'), findsOneWidget);
    expect(find.text('Login'), findsNothing);
  });

  testWidgets('invalid credentials keep the user on login and show an error', (
    tester,
  ) async {
    final dio = fakeApi({'personID': 0});
    addTearDown(dio.close);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [dioProvider.overrideWithValue(dio)],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'test');
    await tester.enterText(find.byType(TextFormField).at(1), 'test');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid username or password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
