
import 'package:flutter/material.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/widgets/logo.dart';


class InsertarScreen extends StatelessWidget {
  const InsertarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controler = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          children: [
            Logo(),
            _Form(),
          

          ],

        )
        ),
    );
  }
}







class _Form extends StatefulWidget {    
 

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
   final TextEditingController controler = TextEditingController();
   final TextEditingController controlerConcepto = TextEditingController();

  @override
  void dispose() {
    // No olvides liberar el controlador cuando ya no se use
    controler.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child:  Column(
        children: [
       
        //  Container(
        //   padding: const EdgeInsets.only(top: 5,left: 5,bottom: 5,right: 20),
        //  decoration: BoxDecoration(
        //   color: Colors.white,
        //   borderRadius: BorderRadius.circular(50),
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Colors.black,
        //       offset: Offset(0,5),
        //       blurRadius: 5
        //     )
        //   ]
        //  ),
        //   child:  TextField(
        //     controller: controler,
        //    autocorrect: false,
        //    keyboardType: const TextInputType.numberWithOptions(signed: true,decimal: true),
        //    decoration: const InputDecoration(
        //    prefixIcon: Icon(Icons.money_rounded),
        //    focusedBorder: InputBorder.none,
        //    enabledBorder: InputBorder.none,
        //    border: InputBorder.none,
        //    hintText: 'importe'

        //    ),
        //   ),
        //   ),
          _TextUser(
            textField: 'importe', 
            controller: controler, 
            obscureText: false, 
            texto: 'importe', 
            icon: const Icon(Icons.note_add_rounded,color:Color(0xff615AAB),), 
            readOnly: false, 
            typeKey: TextInputType.number),

            _TextUser(
            textField: 'concepto', 
            controller: controlerConcepto, 
            obscureText: false, 
            texto: 'concpeto', 
            icon: const Icon(Icons.note_add_rounded,color:Color(0xff615AAB),), 
            readOnly: false, 
            typeKey: TextInputType.text),

         _Button(controller: controler,controllerConcpeto: controlerConcepto,)
      
        ],
      ),
    );
  }
}




class _Button extends StatelessWidget {
  final TextEditingController controller;
   final TextEditingController controllerConcpeto;
  const _Button({super.key, 
  required this.controller, 
  required this.controllerConcpeto
  });

  @override
  Widget build(BuildContext context) {
    return    FilledButton(
          onPressed: ()async {
          
             if (controller.text.isEmpty) {
                await showAlert2(context, 'No ha introducido ningun importe', Environment.proyecto);             
                return;
              }
               if (controllerConcpeto.text.isEmpty) {
                await showAlert2(context, 'No ha introducido ningun concepto', Environment.proyecto);             
                return;
              }

              

              await showAlert2(context, controller.text, Environment.proyecto);  
          }, 
          child: const Text('ver'))
         ;
  }
}

 class _TextUser extends StatelessWidget {
  final String textField;  
  final TextEditingController controller;
  final bool obscureText;
  final String texto ;
  final Icon icon;
  final bool readOnly;
  final TextInputType typeKey;

  const _TextUser({
    required this.textField, 
    required this.controller, 
    required this.obscureText,
    required this.texto,
    required this.icon,
    required this.readOnly,
    required this.typeKey
  
  });

  @override
  Widget build(BuildContext context) {
    final border =  OutlineInputBorder(        
      borderRadius: BorderRadius.circular(40)
    );

    final colors = Theme.of(context).colorScheme;


    return TextField(
      readOnly: readOnly,
      keyboardType: typeKey,
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
        prefixIcon:  icon,
        //prefixIcon:  textField == 'importe' ?  const Icon(Icons.money_outlined,color: Color(0xff615AAB),) :  const Icon(Icons.password,color:Color(0xff615AAB),),
        label:     Text(texto)
      ),
    );
  }
}