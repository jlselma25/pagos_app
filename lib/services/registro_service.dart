import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pagos_app/domains/entities/estadistica.dart';
import 'package:pagos_app/domains/entities/registro.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/models/resultado.dart';
import 'package:shared_preferences/shared_preferences.dart';





class RegistroService  extends ChangeNotifier{

 
   List<Registro> lstRegistros = [];
   List<Estadistica> lstEstadistica = [];
   Map<String, double> estadisticasMap  = {};
   bool verLabel = false;
   double totalSalidas = 0;
   double totalEntradas = 0;
   double saldoActual = 0;
   bool filtar = false;
   Color colors = Colors.black;

    void deleteLista()
    {
      lstRegistros.clear();
      verLabel = false;
    }




Future obtenerSaldo () async{
  
   final id = await getId();   

   final dio = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                           
                            )
                       );     


      final response = await dio.get('/ObtenerSaldo/',
              queryParameters: {
                                  'usuario':id,                          
                                });


      if (response.statusCode == 200){
        saldoActual = response.data; 
           if (saldoActual < 0){
               colors = Colors.red;
           }else{
               colors = Colors.green;
           }  
        notifyListeners();
      }    

      
}


 Future<String> cargarRegistros (String dateFrom, String dateTo) async{ 

     
      lstRegistros.clear();  
      final id = await getId();
      final token = await getToken();
      verLabel= false;
      totalEntradas = 0;
      totalSalidas = 0;


       final dio = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                            headers: {
                                        'Content-Type': 'application/json',
                                        'x-token': token
                                     }
                            )
                       );     


      final response = await dio.get('/ListadoRegistrosFechas/',
              queryParameters: {
                                  'usuario':id,                                   
                                  'fechaDesde':dateFrom.toString(),
                                  'fechaFin':dateTo.toString(),
                                      
                                });

      if (response.statusCode == 200){

        lstRegistros = registrosFromJsonList(response.data);   
       

        if (lstRegistros.isEmpty) 
        {
             return '2';
        }   

   
        verLabel = true;

         for (int i = 0; i < lstRegistros.length; i++) {

            if(lstRegistros[i].tipo == "P"){
              totalSalidas += lstRegistros[i].importe;
            }else{
               totalEntradas +=lstRegistros[i].importe;
            }   
          }

           totalSalidas= double.parse( totalSalidas.toStringAsFixed(2));
           totalEntradas= double.parse( totalEntradas.toStringAsFixed(2));             


        notifyListeners();
        return '1';       
     }  

     return '0';

  }




  Future<String> obtenerEstadisticas (String dateFrom, String dateTo) async{ 

     
      lstRegistros.clear();  
      final id = await getId();
      final token = await getToken();
     


       final dio = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                            headers: {
                                        'Content-Type': 'application/json',
                                        'x-token': token
                                     }
                            )
                       );     


      final response = await dio.get('/ObtenerEstadisticas/',
              queryParameters: {
                                  'usuario':id,                                   
                                  'fechaDesde':dateFrom.toString(),
                                  'fechaFin':dateTo.toString(),
                                      
                                });

      if (response.statusCode == 200){

        lstEstadistica =  estadisticaFromJsonList(response.data);          

        if (lstEstadistica.isEmpty) 
        {
             return '2';
        }       

        estadisticasMap = {  for (var estadistica in lstEstadistica) estadistica.leyenda: estadistica.importe   };

        filtar = true;
        notifyListeners();     
        return '1';       
     }  

     return '0';

  }



  Future<int> getId() async {
     final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     final  id = prefs.getInt('id');   
     return id ?? -1;
  }

  Future<String> getToken() async {
     final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     final  token = prefs.getString('token');   
     return token ?? '';
  }


  Future<String> eliminarRegistr0(int index,int id) async{
    
     if (id != -1)
     {                 
           
          final dio = Dio(BaseOptions(
           baseUrl: Environment.apiUrl,
          ));

          final response = await dio.get('/EliminarRegistro/', queryParameters: {
            'id': id,
          });                                       
                                            
          if (response.statusCode == 200)
          {          
               final respuesta = Resultado.fromJson(response.data);

                if (respuesta.valor == "1")
                {
                  lstRegistros.removeAt(index);

                  if(lstRegistros.isEmpty ){
                      verLabel = false;
                  }else{
                      calcularTotales();
                     
                  }             
                  await obtenerSaldo();                 
                  return "1";
                }    
                
          } 

            return "0";
    }
    else{
      lstRegistros.removeAt(index);
      notifyListeners();
      return "1";
    }
   
  }


  calcularTotales(){

    totalEntradas= 0;
    totalSalidas= 0;
   
     for (int i = 0; i < lstRegistros.length; i++) {

            if(lstRegistros[i].tipo == "P"){
              totalSalidas += lstRegistros[i].importe;
            }else{
               totalEntradas += lstRegistros[i].importe;
            }    
      }

      totalSalidas= double.parse( totalSalidas.toStringAsFixed(2));
      totalEntradas= double.parse( totalEntradas.toStringAsFixed(2));        
  }

}