import 'package:flutter/material.dart';



class CustomButton extends StatelessWidget {
  final Color color;
  final String texto;
  final Function() onTap;

  const CustomButton({
    super.key, 
    required this.color, 
    required this.texto, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {     
    return  ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color:  color,
        child:  InkWell(
          onTap: onTap,
          child:   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Text('      $texto      ',style: const TextStyle(color: Colors.white,fontSize:18),)
            
          ),
        ),
      ),
    );
  }
}





