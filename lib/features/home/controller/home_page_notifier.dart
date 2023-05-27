// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_pix/features/home/model/curated_model.dart';
import 'package:wallpaper_pix/features/home/service/respositary.dart';

final selectImagetoDownloadProvider = StateProvider<String>((ref) {
  return 'Select Image Type';
});

final wallpaperSearchProvider =
    StateNotifierProvider<ImageSearchNotifier, ImageSearchState>((ref) {
  return ImageSearchNotifier(apiRepositary: ref.read(apiServiceProvider));
});

class ImageSearchNotifier extends StateNotifier<ImageSearchState> {
  ImageSearchNotifier({required this.apiRepositary})
      : super(ImageSearchState.initial()) {
    getWallpaperImages(1);
  }

  ApiRepositary apiRepositary;

  ///only called for once
  Future getWallpaperImages(int page) async {
    state = state.copyWith(isFetched: true);
    final listOfWallpaper = await apiRepositary.getImages(page);
    state = state.copyWith(
        isFetched: false,
        imagesData: listOfWallpaper,
        pageNumber: 1,
        isMoreImagesAvailable: true);
  }

  Future fetchMoreWallpaperImages() async {
    if (state.isFetched) return;
    if (!state.isMoreImagesAvailable) return ;
    final currentImageList = state.imagesData;
    final currentPage = state.pageNumber;
    state = state.copyWith(isFetched: true);
    log('fetchMoreWallpaperImages');
    final fetchedImagesData = await apiRepositary.getImages(currentPage + 1);

    final newImagesList = List<Photo>.from(currentImageList)
      ..addAll(fetchedImagesData);

    state = state.copyWith(
        imagesData: newImagesList,
        isFetched: false,
        pageNumber: currentPage + 1,
        isMoreImagesAvailable: fetchedImagesData.isNotEmpty);
  }

  @override
  void dispose() {
    super.dispose();
    state = ImageSearchState.initial();
  }
}

class ImageSearchState extends Equatable {
  final List<Photo> imagesData;
  final bool isFetched;
  final bool isMoreImagesAvailable;
  final int pageNumber;
  const ImageSearchState({
    required this.imagesData,
    required this.isFetched,
    required this.isMoreImagesAvailable,
    required this.pageNumber,
  });

  factory ImageSearchState.initial() {
    return const ImageSearchState(
        imagesData: [],
        isFetched: true,
        isMoreImagesAvailable: false,
        pageNumber: 0);
  }

  @override
  List<Object?> get props =>
      [imagesData, isFetched, isMoreImagesAvailable, pageNumber];

  ImageSearchState copyWith({
    List<Photo>? imagesData,
    bool? isFetched,
    bool? isMoreImagesAvailable,
    int? pageNumber,
  }) {
    return ImageSearchState(
      imagesData: imagesData ?? this.imagesData,
      isFetched: isFetched ?? this.isFetched,
      isMoreImagesAvailable:
          isMoreImagesAvailable ?? this.isMoreImagesAvailable,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
