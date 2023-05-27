// To parse this JSON data, do
//
//     final curatedPhotosModel = curatedPhotosModelFromJson(jsonString);

import 'dart:convert';

CuratedPhotosModel curatedPhotosModelFromJson(String str) => CuratedPhotosModel.fromJson(json.decode(str));

String curatedPhotosModelToJson(CuratedPhotosModel data) => json.encode(data.toJson());

class CuratedPhotosModel {
    CuratedPhotosModel({
        required this.photos,
    });
    List<Photo> photos;

    factory CuratedPhotosModel.fromJson(Map<String, dynamic> json) => CuratedPhotosModel(
       
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    };
}

class Photo {
    Photo({
        required this.id,
        required this.width,
        required this.height,
        required this.url,
        required this.photographer,
        required this.photographerUrl,
        required this.photographerId,
        required this.avgColor,
        required this.src,
        required this.liked,
        required this.alt,
    });

    int id;
    int width;
    int height;
    String url;
    String photographer;
    String photographerUrl;
    int photographerId;
    String avgColor;
    Src src;
    bool liked;
    String alt;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src.toJson(),
        "liked": liked,
        "alt": alt,
    };
}

class Src {
    Src({
        required this.original,
        required this.large2X,
        required this.large,
        required this.medium,
        required this.small,
        required this.portrait,
        required this.landscape,
        required this.tiny,
    });

    String original;
    String large2X;
    String large;
    String medium;
    String small;
    String portrait;
    String landscape;
    String tiny;

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
