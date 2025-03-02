



import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:pagos_app/global/environment.dart';

import 'package:pagos_app/models/resultado.dart';
import 'package:pagos_app/models/tipos.dart';
import 'package:pagos_app/services/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthService extends ChangeNotifier{


  bool _comprobando = false;

  String usuario ='';
  bool get comprobando => _comprobando;

  set comprobando(bool value) {
    _comprobando = value;
    notifyListeners();
  }

  error() {   
    notifyListeners();
  }  
 
 
      final dio = Dio(BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
          'x-token': LocalStorage.prefs.getString('action') ?? ''
  }
      )   
   

      );

     

    Future<String> getToken() async {
     final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     final  token = prefs.getString('action');        
     return token ?? '';
  }

   Future<int> getId() async {
     final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     final  id = prefs.getInt('id');   
   
     return id ?? -1;
  }

   Future<String> getUser() async {
     final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     final  user = prefs.getString('user');        
     return user ?? '';
  }


  



 Future <String> prueba() async {

    final  id = await getId();
       final token =await getToken(); 

       return id.toString()+ token;  
 }

    Future <Map<int, String>> cargarTipos() async { 
      
     final response = await dio.get('/CargarTipos/' );      
     List<Tipos> listaTipos = tiposFromJsonList(response.data);
     Map<int, String> tipoMap = {};    
    
     if (response.statusCode == 200){
         tipoMap = {for (var tipo in listaTipos) tipo.id: tipo.nombre };
         return tipoMap;           
     }
     return tipoMap;     

  }

    Future<bool>login (String email,String pass)  async{   

       final token =await getToken();      
       final dio2 = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                            headers: {
                                        'Content-Type': 'application/json',
                                        'x-token': token
                                     }
                            )
                       );



   
    final response = await dio2.get('/LoginUsuario/',
                                      queryParameters: {
                                        'email':email, 
                                        'pass':pass,
                                        'codigo': Environment.codigoRegistro             
                                      }                 
                );      

     if (response.statusCode == 200){
            final respuesta = Resultado.fromJson(response.data);

             if(respuesta.valor == '0' && respuesta.id == -1){
               return false;
             }
           
           if(respuesta.valor == '1'){

            if (respuesta.token.isNotEmpty){
              saveToken(respuesta.token);
              saveId(respuesta.id);
              saveUser(email);
              usuario = email;
             
            }

            return true;
           }   
            
     }
          
       return false;
     
  }


   Future<String>register(String email,String pass,String codigo)  async{    

    if (codigo == Environment.codigoRegistro){   


      final response = await dio.get('/RegistroUsuario/',
                                        queryParameters: {
                                          'codigo':Environment.codigoRegistro,
                                          'email':email, 
                                          'password':pass             
                                        }                 
                  );      

      if (response.statusCode == 200){
              final respuesta = Resultado.fromJson(response.data);
              saveToken(respuesta.token);
              saveId(respuesta.id);
              return '1';             
      }
    }      
    
    return '0';
     
  }

  Future<void> saveToken(String token  ) async {
      final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     await prefs.setString('action', token);              
  }

  Future<void> saveId(int id  ) async {    
    final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     await prefs.setInt('id', id);             
  }
 Future<void> saveUser(String user ) async {    
    final SharedPreferences prefs  =  await SharedPreferences.getInstance();
     await prefs.setString('user', user);             
  }


  Future<String> saveRegister ( int tipo,  String concpeto, String importe )async{   

        String token = await getToken();
        int id = await getId();

       final dio2 = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                            headers: {
                                        'Content-Type': 'application/json',
                                        'x-token': token
                                     }
                            )
                       );

    final response = await dio2.get('/GuardarRegistro/',
              queryParameters: {                                                                  
                                  'tipo':tipo,
                                  'importe':importe,
                                  'concepto': concpeto,   
                                  'id': id   
                                                               

                                });

     if (response.statusCode == 200){
       
        final respuesta = Resultado.fromJson(response.data);
        return respuesta.valor;
     }
     else{
      return '0';
     }
}



Future<bool> isLogged()async{  


     // Configura el adaptador para ignorar certificados autofirmados

//  if (defaultTargetPlatform == TargetPlatform.android ||
//       defaultTargetPlatform == TargetPlatform.iOS) {
      
//       (dio2.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
//         client.badCertificateCallback = (cert, host, port) => true;
//         return null; // Solo para desarrollo
//       };
//  } 

    final response = await dio.get('/ComprobarUsuario/');
                                      

     if (response.statusCode == 200){
            final respuesta = Resultado.fromJson(response.data);

            
        if (respuesta.valor == '1')
        {
             usuario = await getUser();
             return true;    
        }else{
          return false;
        }            
            
      }
          
      else{
        logOut();
        return false;     
      }     


     
   }

  Future<void> logOut() async{
    final SharedPreferences prefs  =  await SharedPreferences.getInstance();
    // await prefs.remove('token');   
    // await prefs.remove('id');
    await prefs.clear();
  }


  Future<bool> comprobarToken ( )async{      


      String token = await getToken();
     
      final dio2 = Dio(BaseOptions(
                            baseUrl: Environment.apiUrl,
                            headers: {
                                        'Content-Type': 'application/json',
                                        'x-token': token
                                     }
                            )
                       );
    final response = await dio2.get('/ComprobarToken/' );                                      

     if (response.statusCode == 200){
            final respuesta = Resultado.fromJson(response.data);
            
        if (respuesta.valor == '1')
        {
             return true;    
        }else{
          return false;
        }            
            
      }
          
      else{      
        return false;     
      }     
}

}

