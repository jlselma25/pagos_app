

import 'dart:convert';

List<DetalleRegistro> registrosDetalleFromJsonList(List<dynamic> json) => List<DetalleRegistro>.from(json.map((x) => DetalleRegistro.fromJson(x)));
List<DetalleRegistro> registroDetalleFromJson(String str) => List<DetalleRegistro>.from(json.decode(str).map((x) => DetalleRegistro.fromJson(x)));


String registrosDetalleToJson(List<DetalleRegistro> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DetalleRegistro {
  final double importe;  
  final String nombre; 



  DetalleRegistro({
    required this.importe,   
    required this.nombre,
    
    
    });


    factory DetalleRegistro.fromJson(Map<String, dynamic> json) => DetalleRegistro(        
                     
        importe: json["importe"] ?? -1,      
        nombre: json["nombre"],      
        
    );


     Map<String, dynamic> toJson() => {
       
        "importe": importe,      
        "nombre": nombre,      
        
    };


}
