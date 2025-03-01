import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:provider/provider.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
   
      body: FutureBuilder(
        builder: (context, snapshot) {
          return   Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               SpinKitCircle(
                  color: Environment.color,  // El color del spinner
                  size: 50.0,          // Tamaño del spinner
                ),
                const SizedBox(height: 15),
                const Text('Cargando...'),

              ],
            ),           

          );        

        }, future: checkLoginState(context),
       
      )
    );
  }
}


 Future checkLoginState(BuildContext context) async {
  final authService = Provider.of<AuthService>(context, listen: false);

  /////final tipos = await authService.cargarTipos();

  final tipos = await authService.prueba();

 
 
  if(tipos.isNotEmpty){
      Navigator.pushReplacementNamed(context, 'login');  
  }
  else{
     Navigator.pushReplacementNamed(context, 'prueba');  
  }

//     Future.delayed(const Duration(seconds: 5), () {
//        Navigator.pushReplacementNamed(context, 'login');  
//   // Código que se ejecuta después del retraso
// });


    
       
 }