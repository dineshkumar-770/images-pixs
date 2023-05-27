import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_pix/common/toast.dart';

class HelperFunction {
  static Future<void> openUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalApplication,webViewConfiguration: const WebViewConfiguration(enableJavaScript: true,enableDomStorage: true));
    } else {
      FlutterToast.showToast(message: 'unable to launch URL');
    }
  }
}
