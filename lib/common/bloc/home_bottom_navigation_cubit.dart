import 'package:flutter/material.dart';
import 'package:potatoes/common/bloc/cubit_state.dart';
import 'package:potatoes/libs.dart';

class HomeBottomNavigationState extends CubitSuccessState {
  final List<ScrollController> scrollControllers;
  final PageController pageController;
  final int initialIndex;
  final int currentIndex;

  HomeBottomNavigationState._({
    required this.scrollControllers,
    required this.pageController,
    required this.initialIndex,
    required this.currentIndex,
  });

  factory HomeBottomNavigationState.create(
      {required int count, required int initialIndex}) {
    return HomeBottomNavigationState._(
      scrollControllers: List.generate(count, (_) => ScrollController()),
      pageController: PageController(initialPage: initialIndex),
      initialIndex: initialIndex,
      currentIndex: initialIndex,
    );
  }

  HomeBottomNavigationState copyWith({
    int? currentIndex,
    bool animate = true,
  }) {
    if (animate && currentIndex != null) {
      pageController.jumpToPage(currentIndex);
    }

    return HomeBottomNavigationState._(
      scrollControllers: scrollControllers,
      pageController: pageController,
      initialIndex: initialIndex,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  bool get isInInitialPosition => currentIndex == initialIndex;

  void dispose() {
    for (final controller in scrollControllers) {
      controller.dispose();
    }
    pageController.dispose();
  }

  @override
  List<Object?> get props => [initialIndex, currentIndex];
}

class HomeBottomNavigationCubit extends Cubit<HomeBottomNavigationState> {
  HomeBottomNavigationCubit()
      : super(HomeBottomNavigationState.create(count: 3, initialIndex: 0));
  void goToPage({required int index, bool animate = true}) {
    if (index == state.currentIndex) {
      final controller = state.scrollControllers[index];
      if (controller.hasClients) {
        controller.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        // Attendre que le scroll view soit monté
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.hasClients) {
            controller.animateTo(
              0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    } else {
      if (animate) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.pageController.hasClients) {
            state.pageController.jumpToPage(index);
          }
        });
      }
      emit(state.copyWith(currentIndex: index, animate: false));
    }
  }

  void resetToInitialPage({bool animate = true}) {
    emit(state.copyWith(currentIndex: state.initialIndex, animate: animate));
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }
}
