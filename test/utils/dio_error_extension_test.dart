import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';
import 'package:flutter_base_template_1/utils/dio_error_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import '../test_utils/mock_dio_error.dart';

void main() async {
  final localeStrings = await S.load(const Locale.fromSubtags(languageCode: 'en')); // mimic localization delegate init

  group('test errorMessage() extension method for DioError', () {
    test('will return "message" value from first error Data', () {
      final dioError = MockDioError(json: '''
          {
              "errorCode": "1000",
              "message": "Sorry, something went wrong",
              "detail": "Api token not valid"
          }
      ''');

      expect(dioError.errorMessage(), 'Sorry, something went wrong');
    });

    test('will return network error message for DioErrorType.connectTimeout', () {
      final dioError = MockDioError(type: DioErrorType.connectionTimeout);
      expect(dioError.errorMessage(), localeStrings.networkErrorMessage);
    });

    test('will return network error message for DioErrorType.sendTimeout', () {
      final dioError = MockDioError(type: DioErrorType.sendTimeout);
      expect(dioError.errorMessage(), localeStrings.networkErrorMessage);
    });

    test('will return network error message for DioErrorType.receiveTimeout', () {
      final dioError = MockDioError(type: DioErrorType.receiveTimeout);
      expect(dioError.errorMessage(), localeStrings.networkErrorMessage);
    });

    test('will return request canceled error message for DioErrorType.cancel', () {
      final dioError = MockDioError(type: DioErrorType.cancel);
      expect(dioError.errorMessage(), localeStrings.networkRequestCanceled);
    });

    test('will return network error message for DioErrorType.badResponse and error is SocketException',
        () async {
      final dioError = MockDioError(type: DioErrorType.badResponse, error: const SocketException('no internet'));
      expect(dioError.errorMessage(), localeStrings.networkErrorMessage);
    });

    test('will return something went wrong error message for DioErrorType.badResponse', () async {
      final dioError = MockDioError(type: DioErrorType.badResponse);
      expect(dioError.errorMessage(), localeStrings.unknownError);
    });

    test('will return invalid clientId error message for DioErrorType.badCertificate', () async {
      final dioError = MockDioError(type: DioErrorType.badCertificate);
      expect(dioError.errorMessage(), localeStrings.invalidClientIdError);
    });
  });
}
