

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
   Colors.indigo

];

List<FaIcon> icons = const [
  
  FaIcon(FontAwesomeIcons.pizzaSlice,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.moneyBill,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.buildingColumns,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.car,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.houseChimneyWindow,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.laptop,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.carOn,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.utensils,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.planeDeparture,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.faceLaugh,size:25, color: Colors.white,),
  FaIcon(FontAwesomeIcons.shirt,size:25, color: Colors.white,),
];


FaIcon iconsListTittle(String leyenda){

 
  FaIcon icon;

    switch(leyenda){
              case 'ALI':               
                icon = icons[0];
                break;  

               case 'ING':
                  icon = icons[1];
                break;  

               case 'PRE':                
                icon = icons[2];
                break;  

                case 'TRA':                
                 icon = icons[3];
                break;  

               case 'HOG':
                 icon = icons[4];
                break;  

              case 'TEC':
                icon = icons[5];
                break;  

              case 'VEH':
                  icon = icons[6];
                break;  
                
              case 'RES':
                icon = icons[7];
                break;  

               case 'VIA':
                 icon = icons[8];
                break;

               case 'OCI':
                icon = icons[9];
                break;              

               case 'ROP':
                 icon = icons[10];
                break;              
             
               default:
                 icon =  const FaIcon(FontAwesomeIcons.images,size:25, color: Colors.white,);                 

            }

      return icon;

}









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

              case 'VEH':
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

                case 'ROP':
                color = colores[10];
                break;               
             
               default:
               color = Colors.black12;                 

            }

      return color;

}





