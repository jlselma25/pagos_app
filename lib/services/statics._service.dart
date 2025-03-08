

import 'package:flutter/material.dart';

class StaticsService extends ChangeNotifier{

  bool changeColor = true;


  changeColorContainer(bool valor){
    changeColor = valor;
    notifyListeners();

  }
}