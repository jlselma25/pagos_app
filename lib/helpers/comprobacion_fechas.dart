

import 'package:intl/intl.dart';

Future<String> comprobarFechas(String fechaDesde , String fechaHasta) async{

  if (fechaDesde.isEmpty && fechaHasta.isEmpty)  { return 'No ha seleccionado rango de fechas';  }
                            
  if (fechaDesde.isEmpty){ return 'No ha seleccionado fecha desde'; }
                            
  if (fechaHasta.isEmpty) { return 'No ha seleccionado fecha hasta'; }

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  DateTime dateFrom = dateFormat.parse(fechaDesde);
  DateTime dateTo = dateFormat.parse(fechaHasta);

  if (dateFrom.isAfter(dateTo)) { return 'Fecha desde mayor que fecha hasta';  }
  return '';

}




String dateOfDay(){

   DateTime now = DateTime.now();
   String date = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";


   return date;
}