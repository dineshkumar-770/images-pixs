// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wallpaper_pix/features/search/model/ai_generation_model.dart';
import 'package:wallpaper_pix/features/search/service/search_repo.dart';

final aiImagesProvider =
    StateNotifierProvider<AIImagesNotifier, AIImagesState>((ref) {
  return AIImagesNotifier(searchWallpapers: SearchWallpapers());
});

class AIImagesNotifier extends StateNotifier<AIImagesState> {
  AIImagesNotifier({required this.searchWallpapers})
      : super(AIImagesInitialState());

  SearchWallpapers searchWallpapers;

  Future<void> getAIImages(String promptText) async {
    try {
      state = AIImagesLoadingState();
      List<Datum> data = await searchWallpapers.getAIImages(promptText);
      if (data.isNotEmpty) {
        state = AIImagesSuccessState(genetaredImages: data);
      } else {
        state = AIImagesErrorState(errorMessage: 'No Images found!');
      }
    } on SocketException catch (e) {
      state = AIImagesErrorState(errorMessage: e.message);
    }
  }
}

abstract class AIImagesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AIImagesLoadingState extends AIImagesState {}

class AIImagesInitialState extends AIImagesState {}

class AIImagesSuccessState extends AIImagesState {
  final List<Datum> genetaredImages;
  AIImagesSuccessState({
    required this.genetaredImages,
  });
}

class AIImagesErrorState extends AIImagesState {
  final String errorMessage;
  AIImagesErrorState({
    required this.errorMessage,
  });
}
