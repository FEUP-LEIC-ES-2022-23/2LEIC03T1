import 'package:flutter/cupertino.dart';

class ScrollProvider {
  static ScrollController scrollController=ScrollController();

  get controller => scrollController;
}