



import 'package:flutter/material.dart';

class StaticsService extends ChangeNotifier{

  bool changeColor = true;
  bool staticTyep = true;


  changeColorContainer(bool valor){
    changeColor = valor;
    staticTyep = valor;   
    notifyListeners();

  }
}