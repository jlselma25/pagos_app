

import 'dart:convert';

List<Estadistica> estadisticaFromJsonList(List<dynamic> json) => List<Estadistica>.from(json.map((x) => Estadistica.fromJson(x)));
List<Estadistica> estadisticaFromJson(String str) => List<Estadistica>.from(json.decode(str).map((x) => Estadistica.fromJson(x)));

String estadisticaToJson(List<Estadistica> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));








class Estadistica {
    double importe;
    String leyenda;
    String nombre;

    Estadistica({
        required this.importe,
        required this.leyenda,
        required this.nombre,
    });

    factory Estadistica.fromJson(Map<String, dynamic> json) => Estadistica(
        importe: json["importe"]?.toDouble(),
        leyenda: json["leyenda"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "importe": importe,
        "leyenda": leyenda,
        "nombre": nombre,
    };
}