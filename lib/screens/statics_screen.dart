import 'package:flutter/material.dart';

import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/show_alert.dart';
import 'package:pagos_app/services/registro_service.dart';
import 'package:pagos_app/services/statics._service.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';


class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {

   TextEditingController fechaController = TextEditingController();
   TextEditingController fechaHastaController = TextEditingController();
  final FocusNode fechaFocusNode = FocusNode();
  final FocusNode fechaHastaFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;  
     final statticsService = Provider.of<StaticsService>(context, listen: true);
     final registrosService = Provider.of<RegistroService>(context, listen: true);
  

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
         backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {          
             Navigator.pushReplacementNamed(context, 'menu'); 
          },
        ),
      ),
      body: Column(
        children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
                Column(
                  children: [
                    Padding(
                     padding:  const EdgeInsets.symmetric(horizontal: 20),
                     child: SizedBox(
                      width: size.width * 0.50,
                       child:    _TextUser(
                                    typeKey: TextInputType.none,
                                    readOnly: true,  
                                    textField: 'fecha',                             
                                    controller: fechaController,                              
                                    obscureText: false,                             
                                    texto: 'desde fecha',    
                                    onTap: () async {
                                       final DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),  // Fecha inicial
                                            firstDate: DateTime(2000),    // Fecha mínima
                                            lastDate: DateTime(2101),     // Fecha máxima
                                          );
                    
                                          if (picked != null) {
                                            // Si el usuario selecciona una fecha, actualizamos el TextFormField
                                            fechaController.text = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}";
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          }
                                    },                        
                                    icon: const Icon(Icons.date_range_sharp,color:Color(0xff615AAB),),
                                    focusNode: fechaFocusNode,                              
                                        ),
                                  
                                ),
                       ),

                          Padding(
                            padding:  const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: SizedBox(
                            width: size.width * 0.50,
                              child:    _TextUser(
                                typeKey: TextInputType.none,
                                readOnly: true,  
                                textField: 'fecha',                             
                                controller: fechaHastaController,                              
                                obscureText: false,                             
                                texto: 'hasta fecha', 
                                 onTap: () async {
                                   final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),  // Fecha inicial
                                        firstDate: DateTime(2000),    // Fecha mínima
                                        lastDate: DateTime(2101),     // Fecha máxima
                                      );

                                      if (picked != null) {
                                        // Si el usuario selecciona una fecha, actualizamos el TextFormField
                                        fechaHastaController.text = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}";
                                        FocusScope.of(context).requestFocus(FocusNode());
                                      }
                                },                                                   
                                icon: const Icon(Icons.date_range_sharp,color:Color(0xff615AAB),) ,
                                focusNode: fechaHastaFocusNode,                                                          
                                    ),
                              
                            ),
                         ),
                       ],
                      ),

                      SizedBox(width: size.width * 0.05,),

                     FilledButton(
                          
                          style: FilledButton.styleFrom(backgroundColor: Environment.color,),                          
                          onPressed: () async{    

                                   final ok = await registrosService.obtenerEstadisticas(fechaController.text, fechaHastaController.text);
                                  
                                   if (ok == '2')
                                   {
                                 // ignore: use_build_context_synchronously
                                    await showAlert2( context, 'No existe ningun registro en ese periódo', Environment.proyecto);                                
                                    return;
                                 }                      
                                  
                               },                         
                        
                          child:  const Icon(Icons.refresh_rounded),
                           
                        ) ,
             
             ],
           ),
          SizedBox(height: size.height * 0.05,),
          Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow:[
                       BoxShadow(
                      color: Colors.black.withOpacity(0.4), // Color de la sombra
                      offset: const Offset(4, 4), // Desplazamiento de la sombra (horizontal, vertical)
                      blurRadius: 8, // Radio de difuminado de la sombra
                      spreadRadius: 1,
                      )
                    ]
                  ),           
                  
                  width: size.width * 0.90,
                  height: size.height * 0.70,
          
                  child:  Column(
                    
                    children: [                 
                      Padding(
                        padding:  const EdgeInsets.fromLTRB(10, 25, 0, 0),
                        child: Row(
                          children: [
                            const Text('Estadistica',style: TextStyle(fontSize: 18,)),
                           
                            SizedBox(width: size.width * 0.02),
                            
                            Container(                          
                              width: size.width * 0.60,
                              height: size.height * 0.07,                         
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0
          
                                )
                              ),
          
                              child: Row(
                                children: [
                                  _ContainerGrafic(statticsService: statticsService),
                                  SizedBox(height: size.height * 0.08,),
                                  _ContainerList(statticsService: statticsService),
                                   
                                ],
                              ),
          
                            ),
                               
                          ],
                        ),
                      ),
                  

                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 10),
                          child: registrosService.filtar == true ? _showGrafic(registrosService.estadisticasMap) : const ContainerEmpty()
                        ) 
                      ],
                    )
                    ],
                  ),          
                 
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   Widget _showGrafic(  Map<String, double> dataMap){
    final size = MediaQuery.of(context).size;    

  //   Map<String, double> dataMap = {
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };
  
    return Container(
      width: size.width * 0.85,
      height: size.height * 0.55,
      color: Colors.white,

      child: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 800),
        chartRadius: MediaQuery.of(context).size.width / 1.2,
        chartLegendSpacing: 80,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        legendOptions: const LegendOptions(
          legendPosition: LegendPosition.top,
          showLegendsInRow: true,
          legendTextStyle: TextStyle( fontSize: 16)
        ),
        chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
        chartValueStyle: TextStyle(fontSize: 20)
        
      ),
       
        ));
  }
}



class ContainerEmpty extends StatelessWidget {
  const ContainerEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       width:  MediaQuery.of(context).size.width * 0.85,
      height:  MediaQuery.of(context).size.height * 0.55,
      color: Colors.white,
    );
  }
}

class _ContainerList extends StatelessWidget {
  const _ContainerList({
    super.key,
    required this.statticsService,
  });

  final StaticsService statticsService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: (){
           statticsService.changeColorContainer(false);
        },
        child: Container(                              
          width:MediaQuery.of(context).size.width * 0.25 ,
          height: MediaQuery.of(context).size.height * 0.05 ,
          decoration: BoxDecoration(
            color: statticsService.changeColor == true ? Environment.colorTextoMark : Environment.color,
            borderRadius: BorderRadius.circular(60)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Lista',style: TextStyle(color:statticsService.changeColor == true ? Environment.colorText : Environment.colorTextoMark,fontSize: 18),)
            ],
          )
          
          ),
      ),
        
    );
  }


 
}

class _ContainerGrafic extends StatelessWidget {
  const _ContainerGrafic({
    super.key,
    required this.statticsService,
  });

  final StaticsService statticsService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          statticsService.changeColorContainer(true);
        },
        child: Container(                              
          width:MediaQuery.of(context).size.width * 0.25 ,
          height: MediaQuery.of(context).size.height * 0.05 ,
          decoration: BoxDecoration(
            color:   statticsService.changeColor == true ?  Environment.color : Colors.white,
            borderRadius: BorderRadius.circular(60)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Grafico',style: TextStyle(color: statticsService.changeColor == true ? Environment.colorTextoMark : Environment.colorText,fontSize: 18),)
            ],
          )
          
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
  final Icon icon;
  final bool readOnly;
  final TextInputType typeKey;
  final VoidCallback? onTap;
   final FocusNode focusNode;

  const _TextUser({
    required this.textField, 
    required this.controller, 
    required this.obscureText,
    required this.texto,
    required this.icon,
    required this.readOnly,
    required this.typeKey, 
    required this.focusNode,
    this.onTap, 
  
  });

  @override
  Widget build(BuildContext context) {
    final border =  OutlineInputBorder(        
      borderRadius: BorderRadius.circular(40)
    );

    final colors = Theme.of(context).colorScheme;


    return TextFormField(
        onTap: onTap,
        focusNode: focusNode,
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


