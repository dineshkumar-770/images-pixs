// To parse this JSON data, do
//
//     final catagoriesBasedDataModel = catagoriesBasedDataModelFromJson(jsonString);

import 'dart:convert';

CatagoriesBasedDataModel catagoriesBasedDataModelFromJson(String str) =>
    CatagoriesBasedDataModel.fromJson(json.decode(str));

String catagoriesBasedDataModelToJson(CatagoriesBasedDataModel data) =>
    json.encode(data.toJson());

class CatagoriesBasedDataModel {
  CatagoriesBasedDataModel({
    this.page,
    this.perPage,
    required this.media,
    this.totalResults,
    this.nextPage,
    this.id,
  });

  int? page;
  int? perPage;
  List<Media> media;
  int? totalResults;
  String? nextPage;
  String? id;

  factory CatagoriesBasedDataModel.fromJson(Map<String, dynamic> json) =>
      CatagoriesBasedDataModel(
        page: json["page"],
        perPage: json["per_page"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
        "id": id,
      };
}

class Media {
  Media({
    this.type,
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });

  Type? type;
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;
  String? alt;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: typeValues.map[json["type"]],
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: Src.fromJson(json["src"]),
        liked: json["liked"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src?.toJson(),
        "liked": liked,
        "alt": alt,
      };
}

class Src {
  Src({
    this.original,
    this.large2X,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  String? original;
  String? large2X;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  factory Src.fromJson(Map<String, dynamic> json) => Src(
        original: json["original"],
        large2X: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
      };
}

enum Type { PHOTO }

final typeValues = EnumValues({"Photo": Type.PHOTO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
