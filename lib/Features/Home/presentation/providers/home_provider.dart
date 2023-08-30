import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int navigationIndex=1;

  setNavigateIndex(int index){
    navigationIndex = index;
    notifyListeners();
  }

}
