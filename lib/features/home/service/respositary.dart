import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_pix/features/home/model/curated_model.dart';
import 'package:wallpaper_pix/routes/api_routes.dart';

final apiServiceProvider = Provider<ApiRepositary>((ref) {
  return ApiRepositary();
});

// final apiServiceProvider =
//     FutureProvider.family<List<Photo>, int>((ref, page) async {
//   return ApiRepositary().getImages(page);
// });

class ApiRepositary {
  final double limit = 15;
  Future<List<Photo>> getImages([int pageNumber = 1]) async {
    String endpoints =
        '${ApiRoutes.baseUrl}/curated?per_page=$limit&page=$pageNumber';
    Uri url = Uri.parse(endpoints);
    Map<String, String> header = {
      "Authorization": ApiRoutes.apiKey,
    };
    http.Response response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      CuratedPhotosModel fetchedData = CuratedPhotosModel.fromJson(decodedData);
      List<Photo> wallpaperList = fetchedData.photos;
      return wallpaperList;
    } else {
      return <Photo>[];
    }
  }
}
