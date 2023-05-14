import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

extension DioErrorExt on DioError {
  String errorMessage() {
    switch (type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectionError:
        return S.current.networkErrorMessage;
      case DioErrorType.cancel:
        return S.current.networkRequestCanceled;
      case DioErrorType.badCertificate:
        return S.current.invalidClientIdError;
      case DioErrorType.badResponse:
        return _getMessageFromDioErrorType(this);
      case DioErrorType.unknown: 
        return message ?? S.current.somethingWentWrong;
    }
  }

  String _getMessageFromDioErrorType(DioError dioError) {
    switch (dioError.error.runtimeType) {
      case SocketException:
        return S.current.networkErrorMessage;
      default:
        return S.current.unknownError;
    }
  }
}
