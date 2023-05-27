import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_pix/features/search/model/search_wall_model.dart';
import 'package:wallpaper_pix/features/search/service/search_repo.dart';

final catagoriesSearchProvider =
    StateNotifierProvider<CatagoriesSearchNotifier, CatagoriesSearchState>(
        (ref) {
  return CatagoriesSearchNotifier(searchWallpapers: SearchWallpapers());
});

class CatagoriesSearchNotifier extends StateNotifier<CatagoriesSearchState> {
  CatagoriesSearchNotifier({required this.searchWallpapers})
      : super(CatagoriesSearchState.init());

  SearchWallpapers searchWallpapers;

  Future getWallpaperImages(String keyWord) async {
    try {
      state = state.copyWith(isFetched: true);
      final listOfWallpaper =
          await searchWallpapers.getSearchedWallpapers(keyWord);
      state = state.copyWith(
          isFetched: false,
          imagesData: listOfWallpaper,
          pageNumber: 1,
          isMoreImagesAvailable: true);
    } catch (e) {
      throw e.toString();
    }
  }

  Future fetchMoreWallpaperImages(String keyWord) async {
    if (state.isFetched) return;
    if (!state.isMoreImagesAvailable) return;
    final currentImageList = state.imagesData;
    final currentPage = state.pageNumber;
    state = state.copyWith(isFetched: true);
    log('fetchMoreWallpaperImages');
    final fetchedImagesData =
        await searchWallpapers.getSearchedWallpapers(keyWord, currentPage + 1);

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
    CatagoriesSearchState.init();
  }
}

class CatagoriesSearchState extends Equatable {
  final List<Photo> imagesData;
  final bool isFetched;
  final bool isMoreImagesAvailable;
  final int pageNumber;
  const CatagoriesSearchState({
    required this.imagesData,
    required this.isFetched,
    required this.isMoreImagesAvailable,
    required this.pageNumber,
  });
  @override
  List<Object?> get props =>
      [imagesData, isFetched, isMoreImagesAvailable, pageNumber];

  factory CatagoriesSearchState.init() {
    return const CatagoriesSearchState(
        imagesData: [],
        isFetched: false,
        isMoreImagesAvailable: false,
        pageNumber: 1);
  }

  CatagoriesSearchState copyWith({
    List<Photo>? imagesData,
    bool? isFetched,
    bool? isMoreImagesAvailable,
    int? pageNumber,
  }) {
    return CatagoriesSearchState(
      imagesData: imagesData ?? this.imagesData,
      isFetched: isFetched ?? this.isFetched,
      isMoreImagesAvailable:
          isMoreImagesAvailable ?? this.isMoreImagesAvailable,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
