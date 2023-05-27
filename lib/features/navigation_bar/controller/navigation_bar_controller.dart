// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationBarProvider =
    StateNotifierProvider<NavigationBarNotifier, NavigationState>((ref) {
  return NavigationBarNotifier();
});

class NavigationBarNotifier extends StateNotifier<NavigationState> {
  NavigationBarNotifier() : super(NavigationState.initial());

  void getNavBarItems(NavigationBarItem navbarItem) {
    switch (navbarItem) {
      case NavigationBarItem.home:
        state =
            state.copyWith(index: 0, navigationBarItem: NavigationBarItem.home);
        break;
      case NavigationBarItem.catagory:
        state = state.copyWith(
            index: 1, navigationBarItem: NavigationBarItem.catagory);
        break;
      case NavigationBarItem.search:
        state = state.copyWith(
            index: 2, navigationBarItem: NavigationBarItem.search);
        break;
    }
  }
}

// ignore: must_be_immutable
class NavigationState extends Equatable {
  NavigationBarItem navigationBarItem;
  int index;
  NavigationState({
    required this.navigationBarItem,
    required this.index,
  });
  factory NavigationState.initial() {
    return NavigationState(index: 0, navigationBarItem: NavigationBarItem.home);
  }
  @override
  List<Object?> get props => [navigationBarItem, index];

  NavigationState copyWith({
    NavigationBarItem? navigationBarItem,
    int? index,
  }) {
    return NavigationState(
      navigationBarItem: navigationBarItem ?? this.navigationBarItem,
      index: index ?? this.index,
    );
  }
}

enum NavigationBarItem { home, catagory, search }
