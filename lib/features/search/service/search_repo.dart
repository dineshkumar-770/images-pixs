import 'dart:convert';
import 'dart:io';

import 'package:wallpaper_pix/features/search/model/ai_generation_model.dart';
import 'package:wallpaper_pix/routes/api_routes.dart';
import 'package:wallpaper_pix/features/search/model/search_wall_model.dart';
import 'package:http/http.dart' as http;

class SearchWallpapers {
  Future<List<Photo>> getSearchedWallpapers(String searchKeyWord,
      [int page = 1]) async {
    String endpoints =
        '${ApiRoutes.baseUrl}/search?query=$searchKeyWord&per_page=15&page=$page';
    Uri url = Uri.parse(endpoints);
    Map<String, String> headers = {"Authorization": ApiRoutes.apiKey};
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      SearchWallpapersModel data = SearchWallpapersModel.fromJson(decodedData);
      return data.photos;
    } else {
      return [];
    }
  }

  Future<List<Datum>> getAIImages(String prompt) async {
    try {
      String endpoints = ApiRoutes.dallEApiUrl;
      Uri url = Uri.parse(endpoints);
      Map<String, dynamic> body = {
        "prompt": prompt,
        "n": 5,
        "size": "1024x1024"
      };
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${ApiRoutes.dallEApiKey}"
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        DallEImagesModel data = DallEImagesModel.fromJson(decodedData);
        return data.data ?? [];
      } else {
        return [];
      }
    } on SocketException catch (e) {
      throw e.toString();
    }
  }
}
