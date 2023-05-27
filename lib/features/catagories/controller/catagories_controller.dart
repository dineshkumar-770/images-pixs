// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_pix/features/catagories/models/catagories_model.dart';
import 'package:wallpaper_pix/features/catagories/models/catagories_search_model.dart';
import 'package:wallpaper_pix/features/catagories/service/catagories_service.dart';

final catagoriesProvider =
    StateNotifierProvider<CatagoriesNotifier, CatagoriesState<Collection>>(
        (ref) {
  return CatagoriesNotifier(catagoriesService: CatagoriesService());
});

class CatagoriesNotifier extends StateNotifier<CatagoriesState<Collection>> {
  CatagoriesNotifier({required this.catagoriesService})
      : super(CatagoriesState.init()) {
    fetchAvailableCatagories(1);
  }

  CatagoriesService catagoriesService;

  Future<void> fetchAvailableCatagories(int page) async {
    try {
      state = state.copyWith(fecthing: true);
      final availableCatagories =
          await catagoriesService.getAvailableCatagories(page);
      state = state.copyWith(
          collectionsData: availableCatagories,
          fecthing: false,
          pageNumber: 1,
          isMoreCatagoriesAvailable: true);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchMoreAvailableCatagories() async {
    if (state.fecthing) return;
    if (!state.isMoreCatagoriesAvailable) return;
    final currentCatagoriesList = state.collectionsData;
    final currentPage = state.pageNumber;
    state = state.copyWith(fecthing: true);
    log('fetchMoreWallpaperImages');
    final fetchedCatagoriesData =
        await catagoriesService.getAvailableCatagories(currentPage + 1);

    final newCatagoriesList = List<Collection>.from(currentCatagoriesList)
      ..addAll(fetchedCatagoriesData);

    state = state.copyWith(
        collectionsData: newCatagoriesList,
        fecthing: false,
        pageNumber: currentPage + 1,
        isMoreCatagoriesAvailable: fetchedCatagoriesData.isNotEmpty);
  }

  @override
  void dispose() {
    super.dispose();
    CatagoriesState.init();
  }
}

final imagesBasedOnCatagoriesProvider = StateNotifierProvider<
    ImagesBasedOnCatagoriesNotifier, CatagoriesState<Media>>((ref) {
  return ImagesBasedOnCatagoriesNotifier(
      catagoriesService: CatagoriesService());
});

class ImagesBasedOnCatagoriesNotifier
    extends StateNotifier<CatagoriesState<Media>> {
  ImagesBasedOnCatagoriesNotifier({required this.catagoriesService})
      : super(CatagoriesState.init());

  CatagoriesService catagoriesService;
  Future<void> fetchAvailableCatagories(int page, String id) async {
    try {
      state = state.copyWith(fecthing: true);
      final availableCatagories =
          await catagoriesService.getImagesBasedOnCatagories(id, page);
      state = state.copyWith(
          collectionsData: availableCatagories,
          fecthing: false,
          pageNumber: 1,
          isMoreCatagoriesAvailable: true);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchMoreAvailableCatagories(String id) async {
    if (state.fecthing) return;
    if (!state.isMoreCatagoriesAvailable) return;
    final currentCatagoriesList = state.collectionsData;
    final currentPage = state.pageNumber;
    state = state.copyWith(fecthing: true);
    final fetchedCatagoriesData =
        await catagoriesService.getImagesBasedOnCatagories(id, currentPage + 1);

    final newCatagoriesList = List<Media>.from(currentCatagoriesList)
      ..addAll(fetchedCatagoriesData);

    state = state.copyWith(
        collectionsData: newCatagoriesList,
        fecthing: false,
        pageNumber: currentPage + 1,
        isMoreCatagoriesAvailable: fetchedCatagoriesData.isNotEmpty);
  }

  @override
  void dispose() {
    super.dispose();
    CatagoriesState.init();
  }
}

class CatagoriesState<T> extends Equatable {
  final List<T> collectionsData;
  final bool fecthing;
  final bool isMoreCatagoriesAvailable;
  final int pageNumber;
  const CatagoriesState({
    required this.collectionsData,
    required this.fecthing,
    required this.isMoreCatagoriesAvailable,
    required this.pageNumber,
  });
  @override
  List<Object?> get props => [];

  factory CatagoriesState.init() {
    // ignore: prefer_const_constructors
    return CatagoriesState(
        collectionsData: <T>[],
        fecthing: false,
        isMoreCatagoriesAvailable: false,
        pageNumber: 1);
  }

  CatagoriesState<T> copyWith({
    List<T>? collectionsData,
    bool? fecthing,
    bool? isMoreCatagoriesAvailable,
    int? pageNumber,
  }) {
    return CatagoriesState(
      collectionsData: collectionsData ?? this.collectionsData,
      fecthing: fecthing ?? this.fecthing,
      isMoreCatagoriesAvailable:
          isMoreCatagoriesAvailable ?? this.isMoreCatagoriesAvailable,
      pageNumber: pageNumber ?? this.pageNumber,
    );
  }
}
