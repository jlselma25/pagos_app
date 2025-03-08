import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/services/statics._service.dart';
import 'package:pagos_app/widgets/logo.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';


class StaticsScreen extends StatefulWidget {
  const StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;  
     final statticsService = Provider.of<StaticsService>(context, listen: true);
  

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {          
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Logo(),
          SizedBox(height: size.height * 0.10,),
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
                  
                  width: size.width * 0.60,
                  height: size.height * 0.30,
          
                  child:  Column(
                    
                    children: [                 
                      Padding(
                        padding:  const EdgeInsets.fromLTRB(25, 25, 0, 0),
                        child: Row(
                          children: [
                            const Text('Estadistica',style: TextStyle(fontSize: 18,)),
                           
                            SizedBox(width: size.width * 0.15),
                            
                            Container(                          
                              width: 300,
                              height: size.height * 0.80,                         
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0
          
                                )
                              ),
          
                              child: Row(
                                children: [
                                  _ContainerGrafic(statticsService: statticsService),
          
                                  _ContainerList(statticsService: statticsService),
                                   
                                ],
                              ),
          
                            ),
                               
                          ],
                        ),
                      ),
                    SizedBox(height: size.height * 0.05,),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 50),
                          child: _showGrafic()
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

   Widget _showGrafic(){
    final size = MediaQuery.of(context).size;  


    print(size.width);
    print(size.height);

    Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
  
    return Container(
      width: size.width * 0.80,
      height: size.height * 0.60,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartRadius: MediaQuery.of(context).size.width / 4.2,
        chartLegendSpacing: 80,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
       
        ));
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
          width: 100,
          height: 50,
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          statticsService.changeColorContainer(true);
        },
        child: Container(                              
          width:MediaQuery.of(context).size.width * 0.50 ,
          height: MediaQuery.of(context).size.height * 0.25 ,
          decoration: BoxDecoration(
            color:   statticsService.changeColor == true ?  Environment.color : Colors.white,
            borderRadius: BorderRadius.circular(60)
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('Grafico',style: TextStyle(color: statticsService.changeColor == true ? Environment.colorTextoMark : Environment.colorText,fontSize: 12),)
            ],
          )
          
          ),
      ),
        
    );
  }
}