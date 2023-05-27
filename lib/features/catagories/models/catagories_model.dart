import 'dart:convert';

CatagoriesModel catagoriesModelFromJson(String str) => CatagoriesModel.fromJson(json.decode(str));

String catagoriesModelToJson(CatagoriesModel data) => json.encode(data.toJson());

class CatagoriesModel {
    CatagoriesModel({
        required this.page,
        required this.perPage,
        required this.collections,
        required this.totalResults,
        required this.nextPage,
    });

    int page;
    int perPage;
    List<Collection> collections;
    int totalResults;
    String nextPage;

    factory CatagoriesModel.fromJson(Map<String, dynamic> json) => CatagoriesModel(
        page: json["page"],
        perPage: json["per_page"],
        collections: List<Collection>.from(json["collections"].map((x) => Collection.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "collections": List<dynamic>.from(collections.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
    };
}

class Collection {
    Collection({
        required this.id,
        required this.title,
        required this.description,
        required this.private,
        required this.mediaCount,
        required this.photosCount,
        required this.videosCount,
    });

    String id;
    String title;
    String description;
    bool private;
    int mediaCount;
    int photosCount;
    int videosCount;

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        private: json["private"],
        mediaCount: json["media_count"],
        photosCount: json["photos_count"],
        videosCount: json["videos_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "private": private,
        "media_count": mediaCount,
        "photos_count": photosCount,
        "videos_count": videosCount,
    };
}
