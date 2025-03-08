import 'dart:convert';



List<Tipos> tiposFromJson(String str) => List<Tipos>.from(json.decode(str).map((x) => Tipos.fromJson(x)));

List<Tipos> tiposFromJsonList(List<dynamic> json) => List<Tipos>.from(json.map((x) => Tipos.fromJson(x)));

String tiposToJson(List<Tipos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tipos {
    int id;
    String nombre;

    Tipos({
        required this.id,
        required this.nombre,
    });

    factory Tipos.fromJson(Map<String, dynamic> json) => Tipos(
        id: json["id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
    };
}
