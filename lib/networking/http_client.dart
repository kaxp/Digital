import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

/// In this file we will define all of our http clients that
/// will be used for calling APIs, like
/// [defaultHttpClient], when user is not authenticated
/// [authenticationHttpClient], when user is authenticated, etc.
///
/// We can also add the base options, headers, data transformers,
/// interceptors, etc. in the available http clients.

// default timeout value in milliseconds
const kReceiveTimeout = 60000;
const kConnectTimeout = 60000;

const String paramClientId = 'client_id';

Dio defaultHttpClient({
  required String clientId,
}) {
  final dio = Dio();

  // set default timeout value
  dio.options = BaseOptions(
    receiveTimeout: const Duration(milliseconds: kReceiveTimeout),
    connectTimeout: const Duration(milliseconds: kConnectTimeout),
  );

  // add [client_id] query param to each api call
  dio.options.queryParameters[paramClientId] = clientId;

  dio.interceptors.add(LogInterceptor(logPrint: (msg) => debugPrint(msg.toString())));

  // add ssl certificate check
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = _onHttpClientCreateWithCertificateCheck;

  return dio;
}

HttpClient? _onHttpClientCreateWithCertificateCheck(_) {
  final securityContext = SecurityContext(withTrustedRoots: true);
  final httpClient = HttpClient(context: securityContext);
  httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
  return httpClient;
}
