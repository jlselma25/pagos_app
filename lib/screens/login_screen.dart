
import 'package:flutter/material.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/widgets/custom_button.dart';
import 'package:pagos_app/widgets/logo.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  
  LoginScreen({super.key});

  final usuarioController = TextEditingController();
  final passwordController = TextEditingController();
  int contador = 0;


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;   
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
       body: SingleChildScrollView(
        child: Column(
          
          children: [           

                    InkWell(
                      onTap: () {
                        contador++;
                        
                      },
                      child: Logo()
                      ),
                    SizedBox(height: size.height * 0.10,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text('Usuario:' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),                     
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _TextUser(
                        textField: 'email3434',
                        controller: usuarioController,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 20,),    
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text('Contraseña:' ,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),                     
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: _TextUser(
                        textField: 'password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: size.height * 0.10,),                 
                    CustomButton( 
                      color: Environment.color ,
                      texto:   'LOGIN',
                      onTap:() async {
                        final usuario = usuarioController.text; //email
                        final password = passwordController.text;
                        
                        final ok = await authService.login(usuario, password);
          
                       // final ok = await UsersFunction().login(usuario, password);
       
                        if(ok){                         
                          Navigator.pushReplacementNamed(context, 'menu');                                               
          
                        } else {
                          await showAlert2(context, 'Login incorrecto', 'Revise datos de login');
                        }
                        
                      },
                    ),       


                    const SizedBox(height: 20,),
                      InkWell(
                        child: const Text('Crear usuario'),
                        
                        onTap: () async {      
                            Navigator.pushReplacementNamed(context, 'registro');                      
                         },

                         

                      )
  
                    
                  ],
                ),
            //  ),
          //  ),
        ),
      
   //   ),
    );
  }


 
}

class _TextUser extends StatelessWidget {
  final String textField;  
  final TextEditingController controller;
  final bool obscureText;

  const _TextUser({
    required this.textField, 
    required this.controller, 
    required this.obscureText
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
        label:  textField == 'email' ? const Text('email') :  const Text('contraseña')
      ),
    );
  }
}
