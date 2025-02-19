import 'dart:convert';

Resultado resultadoFromJson(String str) => Resultado.fromJson(json.decode(str));

String resultadoToJson(Resultado data) => json.encode(data.toJson());

class Resultado {
    String valor;
    String token;
    int id;

    Resultado({
        required this.valor,
        required this.token,
        required this.id
    });

    factory Resultado.fromJson(Map<String, dynamic> json) => Resultado(
        valor: json["valor"],
        token: json["token"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "valor": valor,
        "token": token,
        "id": id
    };
}
