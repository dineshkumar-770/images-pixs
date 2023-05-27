// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_pix/features/search/model/search_wall_model.dart';
import 'package:wallpaper_pix/features/search/service/search_repo.dart';

final searchWallpaperProvider =
    StateNotifierProvider<SearchWallpapersNotifier, SearchWallpapersState>(
        (ref) {
  return SearchWallpapersNotifier(searchWallpapers: SearchWallpapers());
});

class SearchWallpapersNotifier extends StateNotifier<SearchWallpapersState> {
  SearchWallpapersNotifier({required this.searchWallpapers})
      : super(SearchWallpapersState.init());

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
    SearchWallpapersState.init();
  }
}

class SearchWallpapersState extends Equatable {
  final List<Photo> imagesData;
  final bool isFetched;
  final bool isMoreImagesAvailable;
  final int pageNumber;
  const SearchWallpapersState({
    required this.imagesData,
    required this.isFetched,
    required this.isMoreImagesAvailable,
    required this.pageNumber,
  });
  @override
  List<Object?> get props =>
      [imagesData, isFetched, isMoreImagesAvailable, pageNumber];

  factory SearchWallpapersState.init() {
    return const SearchWallpapersState(
        imagesData: [],
        isFetched: false,
        isMoreImagesAvailable: false,
        pageNumber: 1);
  }

  SearchWallpapersState copyWith({
    List<Photo>? imagesData,
    bool? isFetched,
    bool? isMoreImagesAvailable,
    int? pageNumber,
  }) {
    return SearchWallpapersState(
      imagesData: imagesData ?? this.imagesData,
      isFetched: isFetched ?? this.isFetched,
      isMoreImagesAvailable:
          isMoreImagesAvailable ?? this.isMoreImagesAvailable,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
