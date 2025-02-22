import 'dart:convert';

List<Registro> registrosFromJsonList(List<dynamic> json) => List<Registro>.from(json.map((x) => Registro.fromJson(x)));
List<Registro> registroFromJson(String str) => List<Registro>.from(json.decode(str).map((x) => Registro.fromJson(x)));


String registrosToJson(List<Registro> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Registro {
  final double importe;
  final String fecha;
  final String tipo;
  final String token;
  final String nombre;
  final int id;


  Registro({
    required this.importe, 
    required this.fecha, 
    required this.tipo,
    required this.token,
    required this.nombre,
    required this.id,
    
    
    });


    factory Registro.fromJson(Map<String, dynamic> json) => Registro(
        
        fecha: json["fecha"] ?? '',              
        importe: json["importe"] ?? -1,
        tipo: json["tipo"] ?? '',
        token: json["token"],
        nombre: json["nombre"],
        id: json["id"]
        
    );


     Map<String, dynamic> toJson() => {
       
        "importe": importe,
        "fecha": fecha,
        "tipo": tipo,
        "token": token,
        "nombre": nombre,
    };


}
