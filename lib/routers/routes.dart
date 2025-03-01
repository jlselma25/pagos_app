import 'package:flutter/material.dart';
import 'package:pagos_app/screens/horario_screen.dart';
import 'package:pagos_app/screens/insertar_screen.dart';
import 'package:pagos_app/screens/loading.dart';
import 'package:pagos_app/screens/login_screen.dart';
import 'package:pagos_app/screens/menu.dart';
import 'package:pagos_app/screens/prueba.dart';
import 'package:pagos_app/screens/register_user.dart';
import 'package:pagos_app/screens/registro_screen.dart';





final Map<String,Widget Function(BuildContext context)> appRoutes = {

 
  'login'   :      (_)  =>  LoginScreen(),
  'registro' :      (_)  =>  const RegisterUser(),
  'menu'    :      (_)  =>  const MenuScreen(),  
  'horario' :      (_)  =>  const HorarioScreen(),
  'loading' :      (_)  =>  const LoadingScreen(),
  'listado'   :  (_)  =>  const RegistroScreen(),
  'insertar'   :  (_)  =>  const InsertarScreen(),
  'prueba'   :  (_)  =>  const PruebaScreen()
 

  
  
  
};