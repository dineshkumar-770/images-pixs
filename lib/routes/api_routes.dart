import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/core/shared_prefs.dart';

class ApiRoutes {
  static const String baseUrl = 'https://api.pexels.com/v1';
  static String apiKey = Prefs.getString(ConstantsString.apiKeyStore);
  static const String dallEApiUrl =
      'https://api.openai.com/v1/images/generations';
  static String dallEApiKey = Prefs.getString(ConstantsString.dallEApiKey);
}
