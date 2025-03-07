import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/generar_pdf.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/widgets/custom_button.dart';
import 'package:pagos_app/widgets/logo.dart';

import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen();

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


   bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context, listen: false);
  
    

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        //title:  const Text('Registros'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {          
            Navigator.pop(context);
          },
        ),
        actions: [
           Padding(
             padding: EdgeInsets.only(right: size.width  * 0.03),
             child: Text( 'sesion: ${authService.usuario}',style: const TextStyle(color:Colors.black87),),
           ), 
        ],
       ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Environment.color,
          child: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');           
            authService.logOut();
          }),
      body: SingleChildScrollView(
        child: Column(
             
          children: [
         
            Logo(),
            SizedBox(height: size.height * 0.10),
            
              Row(    
                mainAxisAlignment: MainAxisAlignment.center,          
                children: [                
                  Container(
                    width: size.width * 0.74,
                    child: CustomButton(
                      color: Environment.color,
                      texto: '         CREAR APUNTE         ',
                      onTap: ()  async {

                        setState(() {
                          isLoading = true;
                        });
                        final ok = await authService.comprobarToken();
                        if (ok) {
                          Navigator.pushNamed(context, 'horario'); 
                        }else{
                          await showAlert2( context, 'Error toekn no válido ', Environment.proyecto);  
                           Navigator.pushReplacementNamed(context, 'login'); 
                        }

                         setState(() {
                          isLoading = false;
                        });
                           
                                         
                      },
                    ),
                  ),
                ],
              ),            
            
            SizedBox(height: size.height * 0.03),
        
            Container(
               width: size.width * 0.74,
              child: CustomButton(
                color: Environment.color,
                texto: '         LISTADOS APUNTES ',
                onTap: () async{
                  
                   setState(() {isLoading = true;});

                   final ok = await authService.comprobarToken();

                   if (ok) {
                    Navigator.pushNamed(context, 'listado');   
                   }else{
                    await showAlert2( context, 'Error token no válido ', Environment.proyecto);  
                    Navigator.pushReplacementNamed(context, 'login'); 
                  }
                  setState(() {isLoading = false;});
                },
              ),
            ),
          
            SizedBox(height: size.height * 0.03),
           
            SizedBox(height: size.height * 0.10,),              


            if (isLoading) 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [                   
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpinKitCircle(
                      color: Environment.color,  // El color del spinner
                      size: 50.0,          // Tamaño del spinner
                    ),                   
                    ),
                    const SizedBox(height: 15),
                    const Text('Cargando...'),
                  ],
                ),
        

           
           
              
                
             
          ],
        ),
      ),
    );
  }
}


