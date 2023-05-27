// To parse this JSON data, do
//
//     final dallEImagesModel = dallEImagesModelFromJson(jsonString);

import 'dart:convert';

DallEImagesModel dallEImagesModelFromJson(String str) => DallEImagesModel.fromJson(json.decode(str));

String dallEImagesModelToJson(DallEImagesModel data) => json.encode(data.toJson());

class DallEImagesModel {
    DallEImagesModel({
        this.created,
        this.data,
    });

    int? created;
    List<Datum>? data;

    factory DallEImagesModel.fromJson(Map<String, dynamic> json) => DallEImagesModel(
        created: json["created"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "created": created,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.url,
    });

    String? url;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
