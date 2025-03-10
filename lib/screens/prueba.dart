import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';




class PruebaScreen extends StatelessWidget {
  const PruebaScreen({super.key});

  @override
  Widget build(BuildContext context) {   


   final Map<String, double> mapData = {
  "Flutter": 40,
  "React": 30,
  "Xamarin": 20,
  "Ionic": 10,
  "Angular": 40,
  "C#": 30,
  "Android": 20,
  "Delphi": 10,
   "Swiss": 40,
  "XCode": 30,
  "IOS": 20,
  "C++": 10,
};


    return  Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.all(20),
            child: PieChart(
              chartType: ChartType.ring,
              initialAngleInDegree: 90,
              chartLegendSpacing: 180,
              chartRadius: 250,
              
              dataMap: mapData),
          ),

          ),

      ),
   
      
     
        
    
    
    );
  }
}