

import 'package:flutter/material.dart';
import 'package:pagos_app/domains/entities/detalle_registro_leyenda.dart';
import 'package:pagos_app/global/environment.dart';
import 'package:pagos_app/helpers/numeros_decimales.dart';




void verBottomSheet(BuildContext context,  List<DetalleRegistro> lstDetalleRegistros, String fechaDesde, String fechaHasta) {

     double totalImporte = lstDetalleRegistros.fold(0.0, (sum, producto) => sum + producto.importe);
     
     showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
             return Container(
              decoration: const BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)), 
                          ),
              height: MediaQuery.of(context).size.height * 0.3, 
              width: MediaQuery.of(context).size.height * 0.7 ,   
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [              
                  
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: ListView.separated(
                           itemCount: lstDetalleRegistros.length,
                           itemBuilder: (context,index){
                            final item = lstDetalleRegistros[index]; 
                            final importe = numerosDecimales(item.importe);

                            return  Container(
                               height: MediaQuery.of(context).size.height * 0.07, 
                               width: MediaQuery.of(context).size.height * 0.2 ,
                               decoration: BoxDecoration(
                                color: Environment.color.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10)
                               ),   
                       
                      
                              child: ListTile(                      
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(  'Concepto: ${item.nombre}'),
                                    Text(  '${importe.toString()} €')
                                    ,
                                  ],
                                ),
                                                       
                              ),
                            );
                       
                         },
                          separatorBuilder: (context, int index) {
                        return const Divider(
                          color: Colors.black,
                        );
                                           },
                       
                       ),
                     ),
                   ),

                 Text('Total importe:  ${numerosDecimales(totalImporte)} €',style: const TextStyle(fontWeight: FontWeight.bold),)
                 ],
              ),             
             );
      }

     );

   }
