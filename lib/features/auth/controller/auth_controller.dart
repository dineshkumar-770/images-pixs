// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallpaper_pix/common/constants.dart';
import 'package:wallpaper_pix/features/auth/service/auth_repo.dart';
import 'package:wallpaper_pix/features/database/service/firestore_service.dart';

final authStateProvider =
    StateNotifierProvider<AuthNotifier, AuthStates>((ref) {
  return AuthNotifier(authRepositary: AuthRepositary());
});

class AuthNotifier extends StateNotifier<AuthStates> {
  AuthNotifier({required this.authRepositary}) : super(AuthStateInitialState());

  AuthRepositary authRepositary;

  Future<void> signInWithGoogle() async {
    try {
      state = GoogleSignInLoadingState();
      GoogleSignInAccount? data = await authRepositary.googleSignIn();
      if (data != null) {
        await DataBaseService().saveUserInfo(
            email: data.email,
            name: data.displayName ?? 'No name',
            profileUrl: data.photoUrl ?? ConstantsString.noImageFound);
        state = GoogleSignInSuccessState(userData: data);
      } else {
        log(data.toString());
        state = GoogleSignInErrorState(
            errorMessage: 'Google signin cancelled by user');
      }
    } on Exception catch (e) {
      state = GoogleSignInErrorState(errorMessage: e.toString());
    }
  }
}

abstract class AuthStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleSignInLoadingState extends AuthStates {}

class GoogleSignInSuccessState extends AuthStates {
  final GoogleSignInAccount? userData;
  GoogleSignInSuccessState({
    this.userData,
  });
}

class GoogleSignInErrorState extends AuthStates {
  final String errorMessage;
  GoogleSignInErrorState({
    required this.errorMessage,
  });
}

class AuthStateInitialState extends AuthStates {}
