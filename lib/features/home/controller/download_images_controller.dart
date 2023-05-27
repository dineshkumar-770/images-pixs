// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_pix/common/save_files.dart';

final downloadImageProvider =
    StateNotifierProvider<ImageDownloadNotifier, ImageDownloadState>((ref) {
  return ImageDownloadNotifier(saveWallpapers: SaveWallpapers());
});

class ImageDownloadNotifier extends StateNotifier<ImageDownloadState> {
  ImageDownloadNotifier({required this.saveWallpapers})
      : super(ImageDownloadState.initial());
  SaveWallpapers saveWallpapers;

  Future<void> downloadImage(String imageLink) async {
    try {
      state = state.copyWith(downloading: true);
      await saveWallpapers.download(
        imageLink,
        (recived, total) {
          double progress = (recived / total) * 100;
          log(progress.toString());
        },
      );
      state = state.copyWith(downloading: false);
    } on PlatformException catch (e) {
      state = state.copyWith(downloading: false);
      throw '${e.message}';
    }
  }
}

class ImageDownloadState extends Equatable {
  final bool downloading;
  final double downLoadProcess;
  const ImageDownloadState({
    required this.downloading,
    required this.downLoadProcess,
  });

  factory ImageDownloadState.initial() {
    return const ImageDownloadState(downloading: false, downLoadProcess: 0.0);
  }

//to compare the classes we need values
//and thoes values should be provided here in the list of props to compare the classes or states
  @override
  List<Object?> get props => [downloading, downLoadProcess];

  ImageDownloadState copyWith({
    bool? downloading,
    double? downLoadProcess,
  }) {
    return ImageDownloadState(
      downloading: downloading ?? this.downloading,
      downLoadProcess: downLoadProcess ?? this.downLoadProcess,
    );
  }
}
