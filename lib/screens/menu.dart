import 'package:flutter/material.dart';

import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/widgets/custom_button.dart';
import 'package:pagos_app/widgets/logo.dart';

import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen();
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
       ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Environment.color,
          child: const Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'login');           
         //   authService.logOut();
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
                      texto: '         CREAR REGISTRO         ',
                      onTap: ()  async {
                         Navigator.pushNamed(context, 'horario');                 
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
                texto: '         LISTADOS REGISTROS ',
                onTap: () async{
                   Navigator.pushNamed(context, 'listado');    
                },
              ),
            ),
            SizedBox(height: size.height * 0.03),
           
           
           
            SizedBox(height: size.height * 0.10,),           
           // Text(authService.usuario.nombre), 
              
                
             
          ],
        ),
      ),
    );
  }
}


