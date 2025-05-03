import 'package:flutter/material.dart';
import 'package:potatoes/common/bloc/cubit_state.dart';
import 'package:potatoes/libs.dart';

class HomeBottomNavigationState extends CubitSuccessState {
  final List<ScrollController> scrollControllers;
  final PageController pageController;
  final int initialIndex, currentIndex;

  HomeBottomNavigationState(
    int count,
    this.initialIndex
  ) : scrollControllers = List.generate(count, (i) => ScrollController()),
      pageController = PageController(initialPage: initialIndex),
      currentIndex = initialIndex;

  const HomeBottomNavigationState._(
    this.scrollControllers,
    this.pageController,
    this.initialIndex,
    this.currentIndex
  );

  HomeBottomNavigationState withPage(int? index, bool animate) {
    if (animate) pageController.jumpToPage(index ?? initialIndex);

    return HomeBottomNavigationState._(
      scrollControllers,
      pageController,
      initialIndex,
      index ?? currentIndex
    );
  }

  bool get isInInitialPosition => initialIndex == currentIndex;

  @override
  List<Object?> get props => [
    scrollControllers,
    pageController,
    initialIndex,
    currentIndex
  ];

  void dispose() {
    for (final controller in scrollControllers) {
      controller.dispose();
    }
    pageController.dispose();
  }
}

class HomeBottomNavigationCubit extends Cubit<HomeBottomNavigationState> {
  HomeBottomNavigationCubit() : super(HomeBottomNavigationState(4, 1));

  void goToPage({int? index, bool animate = true}) {
    if (index != null && index == state.currentIndex) {
      // on clique sur un onglet déjà sélectionné
      state.scrollControllers[index].animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn
      );
    } else {
      emit(state.withPage(index, animate));
    }
  }

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }
}