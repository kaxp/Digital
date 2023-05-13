import 'package:flutter_base_template_1/config/flavor_config.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class NetworkConstants {
  static String genericError = S.current.somethingWentWrong;

  static String prodBaseUrl = 'https://api.seatgeek.com/2';
  static String prodClientId = 'MzM2NDA4MTZ8MTY4Mzk0NzE4MS44OTEwNjYz';

  static String stagingBaseUrl = 'https://api.seatgeek.com/2';
  static String stagingClientId = 'MzM2NDA4MTZ8MTY4Mzk0NzE4MS44OTEwNjYz';

  static final String baseUrl = FlavorConfig.instance!.values.baseUrl;
  static final String clientId = FlavorConfig.instance!.values.clientId;
}
