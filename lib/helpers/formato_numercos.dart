

import 'package:intl/intl.dart';


String formatoNumerico(double numero) { 
  return  NumberFormat("##0.00", "es_ES").format( numero);

}