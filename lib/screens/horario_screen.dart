



import 'package:flutter/material.dart';

import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/auth_service.dart';
import 'package:pagos_app/widgets/logo.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HorarioScreen extends StatefulWidget {
  static const name = 'horario_screen';
  const HorarioScreen({super.key});

  @override
  State<HorarioScreen> createState() => _HorarioScreenState();
}

class _HorarioScreenState extends State<HorarioScreen> {
  late TextEditingController tarjetaController;
  final importeController = TextEditingController();
  final conceptoController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  FocusNode focusNodeDate = FocusNode();
  Map<int, String> tiposMap = {};
  Map<int, String> categorias = {};
  int? selectedValue;
  int? selectedValueC;
  bool centro = false;
  bool tieneComida = false;

  @override
  void initState() {
    super.initState();
    tarjetaController = TextEditingController();
    cargarTipos();
    cargarCategorias();
   
  }

  @override
  void dispose() {
    super.dispose();
  }

  void cargarTipos() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    tiposMap = await authService.cargarTipos();
    setState(() {});
  }

  void cargarCategorias() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    categorias = await authService.cargarCategorias();
    setState(() {});
  }

  void recordarCentro() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    centro = prefs.getBool('center') ?? false;
    if (centro) {
      final idCentro = prefs.getInt('id_centro') ?? -1;
      selectedValue = idCentro;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);
  
    final size = MediaQuery.of(context).size;  

    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
          child: Column(
            children: [             
              Logo(),
              SizedBox(  height: size.height * 0.10,),              
                  Row(
                    children: [                   
                    
                      SizedBox(
                        width: size.width * 0.50,
                        child:    _TextUser(
                                      typeKey: TextInputType.none,
                                      readOnly: true,  
                                      textField: 'fecha',
                                      controller: fechaController,
                                      obscureText: false,
                                      texto: 'fecha',
                                      icon: const Icon(Icons.date_range_sharp,color:Color(0xff615AAB),)
                                    ),
                      ),
                    SizedBox(width: size.width * 0.10),
                   
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: _FillButtonDate(
                        fechaController: fechaController,
                      ),
                    ),
                    
               


                    ],
                  ),                                               
              

               const SizedBox( height: 55,),
                   _TextUser(
                    typeKey: TextInputType.text,
                      readOnly: false,
                      textField: 'concepto',
                      controller: conceptoController,
                      obscureText: false,
                      texto: 'concepto',
                      icon: const Icon(Icons.note_add_rounded,color:Color(0xff615AAB),)
                          ),

                const SizedBox( height: 55,),
                
                   _TextUser(
                    typeKey: const TextInputType.numberWithOptions(signed: true,decimal: true),
                      readOnly: false,
                      textField: 'importe',
                      controller: importeController,
                      obscureText: false,
                      texto: 'importe',
                    icon: const Icon(Icons.money_rounded,color:Color(0xff615AAB),)
                          ),



              SizedBox(  height: size.height * 0.05,),

              Row(
                children: [
                  SizedBox(  width: size.width * 0.05,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Environment.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1)),
                    height: size.height * 0.05,
                    width: size.width * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _dropBoxButton(),
                    ),
                  ),

                  SizedBox(  width: size.width * 0.15,),

                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Environment.color,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 1)),
                    height: size.height * 0.05,
                    width: size.width * 0.35,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _dropBoxTypeButton(),
                    ),
                  ),
                ],
              ),        
              
              SizedBox(
                height: size.height * 0.10,
              ),
              _ButtonSave(selectedValue: selectedValue, authService: authService, importe: importeController.text, concepto: conceptoController.text,selectedValueC: selectedValueC,),
            ],
          ),
        ),
      ),
    );
  }


  


  

  DropdownButton<int> _dropBoxButton() { 

    return DropdownButton<int>(
                          hint: const Text('Tipo',style: TextStyle(color: Colors.white),),   
                          iconEnabledColor: Colors.white,   
                          iconSize: 40,                 
                          dropdownColor: Colors.grey.shade600,   
                          underline: Container(),
                          isExpanded: true,                
                          items:   
                           tiposMap.keys.map((int value) {                      
                                   return DropdownMenuItem(
                                        value: value,                                       
                                        child: Text('${tiposMap[value]}',style: const TextStyle(color: Colors.white)));  
                                      }).toList(),

                          value: selectedValue,
                          onChanged: ( valueNew){                            
                            setState(() {
                              selectedValue = valueNew;
                                                          
                             });
                          },                                    
                        
                         );
    }

    DropdownButton<int> _dropBoxTypeButton() { 

    return DropdownButton<int>(
                          hint: const Text('Categoria',style: TextStyle(color: Colors.white),),   
                          iconEnabledColor: Colors.white,   
                          iconSize: 40,                 
                          dropdownColor: Colors.grey.shade600,   
                          underline: Container(),
                          isExpanded: true,                
                          items:   
                           categorias.keys.map((int value) {                      
                                   return DropdownMenuItem(
                                        value: value,                                       
                                        child: Text('${categorias[value]}',style: const TextStyle(color: Colors.white)));  
                                      }).toList(),

                          value: selectedValueC,
                          onChanged: ( valueNew){                            
                            setState(() {
                              selectedValueC = valueNew;
                                                          
                             });
                          },                                    
                        
                         );
    }


  }

  



class _FillButtonDate extends StatelessWidget {
  final TextEditingController fechaController;
  const _FillButtonDate({
    required this.fechaController,
  });

  @override
  Widget build(BuildContext context) { 

    Future<DateTime?> getDate(BuildContext context) {
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2017),
        lastDate: DateTime(2045),
        builder: (context, child) {
          return Theme(
              data: ThemeData.dark(), child: child ?? const Text('data'));
        },
      );
    }

    return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Environment.color,
        ),
        onPressed: ()  {
          getDate(context).then((value) async {
            if (value != null) {
              fechaController.text = '${value.day}/${value.month.toString().padLeft(2, '0')}/${value.year}';            
              
            } else {
              fechaController.clear();
            }
             });
        },
        child: const Icon(Icons.date_range));
  }
}


class _ButtonSave extends StatelessWidget {
  const _ButtonSave({
    super.key,
    required this.selectedValue,
    required this.authService,   
    required this.importe,
    required this.concepto,
     required this.selectedValueC,
    
   
  });

  final int? selectedValue;
   final int? selectedValueC;
  final AuthService authService;  
  final String importe;
  final String concepto;
  

  @override
  Widget build(BuildContext context) {
    return _CustomButton(
        color: Environment.color,
        texto: 'GUARDAR',
        onTap: () async {     
                     
      //  if (kIsWeb) {  
         
      //         if (importe.isEmpty) {
      //           await showAlert2(context, 'No ha introducido ningun importe', Environment.proyecto);             
      //           return;
      //         }

      //         if (concepto.isEmpty) {
      //           await showAlert2(context, 'No ha introducido concepto', Environment.proyecto);                   
      //           return;
      //         }
      //          if (selectedValue == null) {
      //           await showAlert2(context, 'No ha seleccionado ningun tipo', Environment.proyecto);                   
      //           return;
      //         }
      //   } else {
           
      //         if (selectedValue == null) {
      //           showAlert(context, 'No ha seleccionado ningun tipo', Environment.proyecto);
      //           return;
      //         }
      //         if (importe.isEmpty) {
      //           showAlert(context, 'No ha introducido ningun importe', Environment.proyecto);
      //           return;
      //         }

      //         if (concepto.isEmpty) {
      //           showAlert(context, 'No ha introducido concepto', Environment.proyecto);
      //           return;
      //         }
      //     }
        try{

          

           

           final ok = await authService.saveRegister( selectedValue!,selectedValueC ?? 0, concepto, importe);                    
    
           if (ok == '0') {
              // ignore: use_build_context_synchronously
              await showAlert2( context, 'Error al guardar registro ', Environment.proyecto);  
                  
          } else {
             await showAlert2(context, 'Registro insertado correctamente', Environment.proyecto);                 
             // ignore: use_build_context_synchronously
             Navigator.pushReplacementNamed(context, 'menu');    
           
          }
        }catch(error){
          // ignore: use_build_context_synchronously
          await showAlert2( context, 'No ha rellenado todos los campos', Environment.proyecto);

        }
         
        
        });
  }
}





class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final TextEditingController importeControler = TextEditingController();
  final TextEditingController fechaController= TextEditingController();
  final TextEditingController conceptoController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context,listen: false);

    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
           _TextUser(
                    typeKey: const TextInputType.numberWithOptions(signed: true,decimal: true),
                      readOnly: false,
                      textField: 'importe',
                      controller: importeControler,
                      obscureText: false,
                      texto: 'importeeeeee',
                    icon: const Icon(Icons.money_rounded,color:Color(0xff615AAB),)
                    ),

           _ButtonSave(selectedValue: 1, authService: authService, importe: importeControler.text, concepto: conceptoController.text,selectedValueC: 1,),
          ],
        ),




    );
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


    return TextFormField(
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






class _CustomButton extends StatelessWidget {
  final Color color;
  final String texto;
  final Function() onTap;

  const _CustomButton({
    super.key, 
    required this.color, 
    required this.texto, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
     final authService = Provider.of<AuthService>(context);
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color:  color,
        child:  InkWell(
          onTap: onTap,
          child:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: authService.comprobando == false 
            ? Text('      $texto      ',style: const TextStyle(color: Colors.white,fontSize:20),)
            : const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            )
          ),
        ),
      ),
    );
  }
}



class _TextFieldForm extends StatelessWidget {

  final String textField  ;
  final TextEditingController textController;
  final FocusNode focusNode;

  const _TextFieldForm({

    required this.textField,
    required this.textController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {

    final  outlineInputBorder = UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40));


      final inputDecoration =InputDecoration(
          hintText: textField,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,

          filled: true,
          // suffixIcon: IconButton(
          //               icon:const Icon(Icons.send_outlined),
          //               onPressed: () {
          //                  final textValue =textController.value.text;
          //                  print('button: $textValue');
          //                 //onValue(textValue);
          //                  textController.clear();
          //               }),

      );



    return  Row(

       children: [

           Expanded(
            child: TextFormField(
              onTapOutside: (event) => focusNode.unfocus(),
              focusNode:focusNode,
              decoration: inputDecoration,
              controller: textController,
              onFieldSubmitted: (value) {            
                       
                  textController.clear();
                  focusNode.requestFocus();
              }
                  )
              ),
           const SizedBox(width: 10,),

           ClipRRect(
             borderRadius: BorderRadius.circular(20),
             child: Material(
                  color:const Color(0xff615AAB),
                  child:  InkWell(
                    onTap:(){
                     
                    },
                    child:  const  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Icon(Icons.camera_alt_rounded,color:Colors.white)
                      ),
                    ),
                  ),
                ),      
            ],
    );
  }
}


class _TextFormFieldDate extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final TextEditingController textController;
  final FocusNode focusNode;

  const _TextFormFieldDate({
    required this.hintText,
    required this.readOnly,
    required this.textController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = UnderlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    final inputDecoration = InputDecoration(
      hintText: hintText,
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      filled: true,
      
    );

    return TextFormField(
        onTapOutside: (event) => focusNode.unfocus(),
        focusNode: focusNode,
        readOnly: readOnly,
        decoration: inputDecoration,
        controller: textController,
        onFieldSubmitted: (value) {
        
          //  onValue(value);
          textController.clear();
          focusNode.requestFocus();
        });
  }
}





String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Viernes';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return '';
    }
  }

  String _getMonth(int day) {
    switch (day) {
      case 1:
        return 'Enero';
      case 2:
        return 'Febrero';
      case 3:
        return 'Marzo';
      case 4:
        return 'Abril';
      case 5:
        return 'Mayo';
      case 6:
        return 'Junio';
      case 7:
        return 'Julio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Septiembre';
      case 10:
        return 'Octubre';
      case 11:
        return 'Noviembre';
      case 12:
        return 'Diciembre';
      default:
        return '';
    }
  }