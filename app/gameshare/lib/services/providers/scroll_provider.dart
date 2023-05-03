import 'package:flutter/cupertino.dart';

class ScrollProvider {
  static ScrollController scrollController = ScrollController();

  get controller => scrollController;
  void goTo(double x){
    scrollController.animateTo(x,
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

}
