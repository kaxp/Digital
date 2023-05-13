import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class NetworkConstants {
  static String genericError = S.current.somethingWentWrong;

  static String prodBaseUrl = '';
  static String prodAuthorization = '';

  static String stagingBaseUrl = '';
  static String stagingAuthorization = '';

  static final String baseUrl = FlavorConfig.instance!.values.baseUrl;
  static final String authorization = FlavorConfig.instance!.values.authorization;
}
