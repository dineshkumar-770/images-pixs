import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class SaveWallpapers {
  static final String _fileName =
      '${DateFormat('dd-mm-yyyy-hh-mm-ss').format(DateTime.now())}.jpeg';
  DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
  final Dio _dio = Dio();
  Future<Directory> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      Directory? path = await DownloadsPathProvider.downloadsDirectory;
      return path ?? Directory('');
    } else {
      final otherPath = await getApplicationDocumentsDirectory();
      return otherPath;
    }
  }

  Future<bool> _requestPermissions() async {
    AndroidDeviceInfo androidInfo = await infoPlugin.androidInfo;
    int osVersion = int.parse(androidInfo.version.release);
    if (osVersion >= 13) {
      PermissionStatus photosPermission = await Permission.photos.request();
      PermissionStatus videoPermission = await Permission.videos.request();
      if (photosPermission.isGranted && videoPermission.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      PermissionStatus storagePermission = await Permission.storage.request();
      if (storagePermission.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future download(String imageUrl, void Function(int, int)? progress) async {
    final dir = await _getDownloadDirectory();
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      final savePath = path.join(dir.path, _fileName);
      await _startDownload(savePath, imageUrl, progress);
    } else {}
  }

  Future _startDownload(
      String savePth, String url, void Function(int, int)? progress) async {
    await _dio.download(url, savePth,
        deleteOnError: true, onReceiveProgress: progress);

    await ImageGallerySaver.saveFile(savePth);
  }
}
