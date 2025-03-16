

import 'package:flutter/material.dart';
import 'package:pagos_app/domains/entities/registro.dart';





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
            margin: const EdgeInsets.symmetric(vertical: 50),
            child: _CustopmListtile()
          ),

          ),

      ),
   
      
     
        
    
    
    );
  }
}




class _CustopmListtile extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    List<Registro> lst = [
      Registro(importe: 24, fecha: '01/', tipo: 'C', token: 'dddddd', nombre: 'jose', id: 2, leyenda: 'al'),
      Registro(importe: 24, fecha: '01/', tipo: 'C', token: 'dddddd', nombre: 'jose', id: 2, leyenda: 'al'),

    ];
    return Container(
      width: 800,
      height: 800,
      color: Colors.grey.withOpacity(0.5),
      child: ListView.builder(
        itemCount: lst.length,
        itemBuilder: (context,index) {

          final item =lst[index];

          return ListTile(
            leading:SizedBox(
              width: 40,
              height: 40,
              child: Container(
                
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.circular(10)

                ),
                child: Column(
                
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(item.importe.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
                      )
                      ),
                  ],
                ))),
            title: Container(
              
              height: 40,
             
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                 color: Colors.white,
              ),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal:10,vertical: 10),
                 child: Text(item.nombre.toString(),style: const TextStyle(fontWeight: FontWeight.bold),),
               ),
            )
          );

        }
        
        
        ),
    );
  }
}








class _StackContainer extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    
         Container(
          
          width: 408,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
        
    
        ),
        Container(
          
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.7),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.zero,bottomRight: Radius.zero)
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text('35 €',style: TextStyle(fontWeight: FontWeight.bold)),
                )
                )
            ],
          ),
    
        ),
    
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          width: 360,
          height: 40,
          decoration:  BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: const BorderRadius.only(topLeft: Radius.zero,bottomLeft: Radius.zero,topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
          ),
           child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Text('concepoto',style: TextStyle(fontWeight: FontWeight.bold)),
                )
                )
            ],
          ),
    
        )
      ],
    );
  }
}