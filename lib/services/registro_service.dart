import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pagos_app/domains/entities/registro.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/models/resultado.dart';
import 'package:shared_preferences/shared_preferences.dart';





class RegistroService  extends ChangeNotifier{



   List<Registro> lstRegistros = [];
   bool verLabel = false;
   double totalSalidas = 0;
   double totalEntradas = 0;
  


     void deleteLista()
    {
      lstRegistros.clear();
      verLabel = false;
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
        notifyListeners();

        if (lstRegistros.isEmpty) 
        {
             return '2';
        }         

       if (lstRegistros[0].token == '3'){
          return '3';
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
                  
                  notifyListeners();
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