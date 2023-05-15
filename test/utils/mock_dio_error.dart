import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

const String validJson = '''
          {
              "detail": "error",
              "message": "Not Found",
              "errorCode": 404
          }
      ''';

class MockDioError extends Mock implements DioError {
  MockDioError({
    String json = validJson,
    this.type = DioErrorType.badResponse,
    this.error,
    this.message = '',
  }) : response = Response(
          requestOptions: RequestOptions(path: 'url'),
          data: jsonDecode(json),
        );

  final Response response;
  final DioErrorType type;
  final dynamic error;
  final String message;

  MockDioError.withErrorData({
    String errorCode = '1000',
    String title = 'title',
    String detail = 'detail',
    this.message = '',
  })  : response = Response(
          requestOptions: RequestOptions(path: 'url'),
          data: {
            'errors': [
              {
                'errorCode': errorCode,
                'title': title,
                'detail': detail,
              }
            ]
          },
        ),
        type = DioErrorType.badResponse,
        error = null;
}
