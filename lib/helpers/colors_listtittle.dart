

import 'package:flutter/material.dart';
List<Color> colores = const [

   Color(0xFF42A5F5),
   Color( 0xFF76E8AA),
   Color(0xFFf9382c),
   Color(0xFFf1864c),
   Color(0xFF256752),
   Color(0xFFedf866),
   Color(0xFFfca2e8),
   Color(0xFF78b6d3), 
   Color(0xFF9178d3),   
  Color(0xFF2cf11c),   

   



   




];



Color colorListTittle(String leyenda){

  Color color;

    switch(leyenda){
              case 'ALI':
                color = colores[0];
                break;  

               case 'ING':
                color = colores[9];
                break;  

               case 'PRE':
                color = colores[7];
                break;  

                case 'TRA':
                color = colores[8];
                break;  

               case 'HOG':
                color = colores[6];
                break;  

              case 'TEC':
                color = colores[4];
                break;  

              case 'VEC':
                color = colores[5];
                break;  
                
              case 'RES':
                color = colores[3];
                break;  

               case 'VIA':
                color = colores[1];
                break;

               case 'OCI':
                color = colores[2];
                break;

                
             
               default:
               color = Colors.black12;                 

            }

      return color;

}