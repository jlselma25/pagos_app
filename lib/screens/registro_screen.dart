import 'package:flutter/material.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/comprobacion_fechas.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/registro_service.dart';
import 'package:pagos_app/widgets/logo.dart';



import 'package:provider/provider.dart';





class RegistroScreen extends StatefulWidget {

  
  const RegistroScreen({super.key});  
    @override
  State<RegistroScreen> createState() => _RegistroScreen();
}

class _RegistroScreen extends State<RegistroScreen>  {

  final TextEditingController tarjetaController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController fechaControllerHasta = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNodeDate = FocusNode();
 
@override
  
  @override
  void initState() {    
    super.initState();
   final registroService = Provider.of<RegistroService>(context,listen: false); 
    registroService.deleteLista(); 
      
   
  }



  @override
  Widget build(BuildContext context) {
    
      final size = MediaQuery.of(context).size;    
      final registroService = Provider.of<RegistroService>(context);    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        centerTitle: true,
      ),
      
        body: SingleChildScrollView(
          child: Column(
           
            children: [
              Logo(),
              SizedBox(height:size.width * 0.02),
               Row(
                children: 
                [
                  SizedBox(width: size.width * 0.05),
                  const Text('Desde fecha'),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.all(9.0),
                child:  Row(
                  children: [
                    SizedBox(width: size.width * 0.60,                  
                      child: _TextFormFieldDate(
                                    hintText: '',
                                    readOnly: true,
                                    textController: fechaController,
                                    focusNode: focusNodeDate),
                    ),
                    const Spacer(),
                   _FillButtonDate(
                          fechaController: fechaController,
                        ),
                  ],
                ),
              ) ,

              SizedBox(height:size.width * 0.02),

              Row(
                children: 
                [
                  SizedBox(width: size.width * 0.05),
                  const Text('Hasta fecha'),
                ],
              ),
          
              Padding(
                padding: const EdgeInsets.all(9.0),
                child:  Row(
                  children: [
                    SizedBox(width: size.width * 0.60,                  
                      child: _TextFormFieldDate(
                                    hintText: '',
                                    readOnly: true,
                                    textController: fechaControllerHasta,
                                    focusNode: focusNodeDate),
                    ),
                    const Spacer(),
                   _FillButtonDate(
                          fechaController: fechaControllerHasta,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child:  Row(
                  children: [
                        SizedBox(width: size.width * 0.02,),                         
                       
                        FilledButton(
                          
                          style: FilledButton.styleFrom(backgroundColor: Environment.color,),                          
                          onPressed: () async{ 
                              
                            String mensaje = await comprobarFechas(fechaController.text, fechaControllerHasta.text);

                            if (mensaje.isNotEmpty)
                            {
                               await showAlert2( context, mensaje, Environment.proyecto);
                               return;
                            }

                                      
                            final ok = await registroService.cargarRegistros(fechaController.text, fechaControllerHasta.text);

                            if (ok == '0')
                            {
                                 await showAlert2( context, 'Error al cargar registros', Environment.proyecto);
                                 return;
                            }
                            if (ok == '2')
                            {
                                 // ignore: use_build_context_synchronously
                                 await showAlert2( context, 'No existe ningun registro en ese periódo', Environment.proyecto);
                                
                                 return;
                            }
                            if (ok == '3')
                            {
                                 await showAlert2( context, 'Token no válido necesita iniciar sesión de nuevo', Environment.proyecto);
                                  Navigator.pushNamed(context, 'login');    
                                 return;
                            }


                          }, 
                          child:const  Icon(Icons.refresh_rounded)
                        ) ,
                               
                  ],
                ),
                
              ), 
               if (registroService.verLabel == true)  
              ...[
                 Row(
                  
                   children: [
                  //   const Padding(
                  //    padding: EdgeInsets.symmetric(horizontal: 10),
                  //    child: Text('Listado de registros' , style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  //  ),
                        SizedBox(width: size.width * 0.10,),    
                      
                      if (registroService.verLabel == true)
                      ...[
                            Container(                          
                                width: size.width * 0.38,
                                height: size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.5),  // Color del fondo del contenedor
                                  borderRadius: BorderRadius.circular(20.0),  // Bordes redondeados
                                      ),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,                       
                                  children: [                         
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Total salidas' , style: TextStyle( fontSize: 16,fontWeight: FontWeight.bold,),),                                  
                                        ],
                                      ),
                                
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${registroService.totalSalidas} €' , style: const TextStyle( fontSize: 16,fontWeight: FontWeight.bold,),),                                  
                                        ],
                                      )
                                    
                                  ],
                                )
                                ),

                          SizedBox(width: size.width * 0.05,),    
                          Container(                          
                                width: size.width * 0.38,
                                height: size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.6),  // Color del fondo del contenedor
                                  borderRadius: BorderRadius.circular(20.0),  // Bordes redondeados
                                      ),
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Total entradas' , style: TextStyle( fontSize: 16,fontWeight: FontWeight.bold,),),
                                          
                                        ],
                                      ),
                                    
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('${registroService.totalEntradas} €' , style: const TextStyle( fontSize: 16,fontWeight: FontWeight.bold,),),
                                          
                                        ],
                                      ),                           
                                  ],
                                )
                                ),                       
                        ],
                   ]
                  )
             
              
              ],   
          
            SizedBox(height: size.height * 0.01,),
          
            SizedBox(
                  width: double.infinity,
                  height:  size.height * 0.40,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: registroService.lstRegistros.length,
                    itemBuilder: (context, index) {                     
                      return Card(
                        elevation: 0.0,
                        color: registroService.lstRegistros[index].tipo == 'I' ?  Colors.green.withOpacity(0.6) : Colors.red.withOpacity(0.5),
                        child:  ListTile(                          
                          title:  Text('${registroService.lstRegistros[index].fecha.toString().padRight(12,' ')}    ${registroService.lstRegistros[index].nombre.toString().padRight(14,' ')}     ${registroService.lstRegistros[index].importe.toString().padLeft(7,' ')} € ' ,style: const TextStyle(color: Colors.white),),   
                          trailing: IconButton(
                            onPressed: () async {
                              final resultado = await registroService.eliminarRegistr0(index,registroService.lstRegistros[index].id);                         

                              if(resultado == "0")
                              {
                                 showAlert2(context, 'Error al eliminar registro',Environment.proyecto);
                                 return;
                              }
                           
                            },
                            icon: const Icon(Icons.delete, color: Colors.black,)
                            ),
                          
                                               
                        ),
                      );
                    },
                    separatorBuilder: (context, int index) {
                      return const Divider(
                        color: Colors.black,
                      );
                    },
                  )),           
                 

                 
            ],
          ),
        ),
         
      
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
        onPressed: () {
          getDate(context).then((value) {
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



class _TextFormField extends StatelessWidget {
  final String hintText;
  final bool readOnly;
  final TextEditingController textController;
  final FocusNode focusNode;

  const _TextFormField({
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



 