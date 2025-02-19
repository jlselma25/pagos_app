import 'package:flutter/material.dart';



class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: SizedBox(
             width: size.width * 0.90,
             height: 120,
              child: const _Imagen(),
            ),
        ),      
      
      
    );
  }
}

class _Imagen extends StatelessWidget {
  const _Imagen();

  @override
  Widget build(BuildContext context) {


      final size =MediaQuery.of(context).size;
     final decoration = BoxDecoration(
      borderRadius:  BorderRadius.circular(10),
      boxShadow:  const [
        BoxShadow(
          color: Colors.transparent,
          blurRadius: 10,
          offset: Offset(0,10)
        )
      ]

    );



    return Container(
      width: double.infinity,
      height: size.height * 0.10,
      color: Colors.white,
      child: DecoratedBox(
      
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const Image(image: AssetImage('assets/voley.png'),
          fit: BoxFit.contain
          )
          ),
      ),
    );
  }
}