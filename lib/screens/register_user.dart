

import 'package:flutter/material.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/widgets/custom_button.dart';
import 'package:pagos_app/widgets/logo.dart';

import 'package:provider/provider.dart';


class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final codigoSeguridadController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;   
    final authService = Provider.of<AuthService>(context,listen: false);

    return  Scaffold(
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
      body: SafeArea(
        child: Container(
           padding: const EdgeInsets.only(top: 3,left: 40,bottom: 3,right: 40),   
           child: SingleChildScrollView(
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Logo(),
             
                  const SizedBox(height: 40,),
             
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Registro usuario',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    ],
                  ),
             
                  const SizedBox(height: 80,),            

                       _TextUser(
                          textField: 'codigo',
                          controller: codigoSeguridadController,
                          obscureText: true,
                          texto: 'codigo seguridad',
                        ),
                  const SizedBox(height: 30,),
              
                 _TextUser(
                          textField: 'email',
                          controller: emailController,
                          obscureText: false,
                          texto: 'email',
                        ),
             
                const SizedBox(height: 30,),
             
                 _TextUser(
                          textField: 'password',
                          controller: passwordController,
                          obscureText: true,
                          texto: 'contraseña',
                        ),
                 SizedBox(height: size.height * 0.10,),                 
                      CustomButton( 
                        color: Environment.color ,
                        texto:   'REGISTRAR',
                        onTap:() async {
                          final password = passwordController.text;
                          final  email=  emailController.text;
                          final  codigo= codigoSeguridadController.text;
                         

                          // String hashedPassword = BCrypt.hashpw(passwordNueva, BCrypt.gensalt());                                      
                         
                       
                           final ok = await authService.register(email,password,codigo);

                            if(ok == "1"){
                            Navigator.pushReplacementNamed(context, 'login');
                            }else{
                              await showAlert2(context, 'Codigo seguridad incorrecto', Environment.proyecto);
                            }                       
                       
                        },
                      ),       
                
                
             
             
                       
                
                  
              ],
                       ),
           ),
        ),
      ),
    );
  }
}



  class _TextUser extends StatelessWidget {
  final String textField;  
  final TextEditingController controller;
  final bool obscureText;
  final String texto ;

  const _TextUser({
    required this.textField, 
    required this.controller, 
    required this.obscureText,
    required this.texto
  });

  @override
  Widget build(BuildContext context) {
    final border =  OutlineInputBorder(        
      borderRadius: BorderRadius.circular(40)
    );

    final colors = Theme.of(context).colorScheme;


    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      decoration:  InputDecoration(   
      
        fillColor: Colors.white,     
        filled: true,      
        enabledBorder: border,
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),          
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red.shade800)),
        isDense: true,
        focusColor: colors.primary,          
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        prefixIcon:  textField == 'email' ?  const Icon(Icons.mail_outline_sharp,color: Color(0xff615AAB),) :  const Icon(Icons.password,color:Color(0xff615AAB),),
        label:     Text(texto)
      ),
    );
  }
}