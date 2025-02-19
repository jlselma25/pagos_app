import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pagos_app/domains/entities/registro.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';





class RegistroService  extends ChangeNotifier{



   List<Registro> lstRegistros = [];
   bool verLabel = false;
  


     void deleteLista()
    {
      lstRegistros.clear();
    }

 Future<String> cargarRegistros (String dateFrom, String dateTo) async{ 

     
      lstRegistros.clear();  
      final id = await getId();
      final token = await getToken();
      verLabel= false;


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



}