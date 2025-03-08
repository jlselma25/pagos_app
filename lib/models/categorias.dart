import 'dart:convert';

List<Categorias> categoriasFromJson(String str) => List<Categorias>.from(json.decode(str).map((x) => Categorias.fromJson(x)));

List<Categorias> categoriasFromJsonList(List<dynamic> json) => List<Categorias>.from(json.map((x) => Categorias.fromJson(x)));

String caegoriasToJson(List<Categorias> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categorias {
    int numero;
    String nombre;

    Categorias({
        required this.numero,
        required this.nombre,
    });

    factory Categorias.fromJson(Map<String, dynamic> json) => Categorias(
        numero: json["numero"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "numero": numero,
        "nombre": nombre,
    };
}