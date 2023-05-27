import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_pix/features/catagories/models/catagories_model.dart';
import 'package:wallpaper_pix/features/catagories/models/catagories_search_model.dart';
import 'package:wallpaper_pix/routes/api_routes.dart';

class CatagoriesService {
  Future<List<Collection>> getAvailableCatagories([int pageNumer = 1]) async {
    try {
      String endpoints =
          '${ApiRoutes.baseUrl}/collections/featured?page=$pageNumer&per_page=15';
      Uri url = Uri.parse(endpoints);
      Map<String, String> headers = {"Authorization": ApiRoutes.apiKey};

      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        CatagoriesModel catagoriesModel = CatagoriesModel.fromJson(decodedData);
        List<Collection> collectionsData = catagoriesModel.collections;
        return collectionsData;
      } else {
        return [];
      }
    } on SocketException catch (e) {
      throw e.message;
    }
  }

  Future<List<Media>> getImagesBasedOnCatagories(String id,
      [int page = 1]) async {
    try {
      String endpoints =
          '${ApiRoutes.baseUrl}/collections/$id?type=photos&page=$page&per_page=15';
      Uri url = Uri.parse(endpoints);
      Map<String, String> headers = {"Authorization": ApiRoutes.apiKey};
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        CatagoriesBasedDataModel catagoriesBasedDataModel =
            CatagoriesBasedDataModel.fromJson(decodedData);
        List<Media> data = catagoriesBasedDataModel.media;
        return data;
      } else {
        return [];
      }
    } on SocketException catch (e) {
      throw e.message.toString();
    }
  }
}
