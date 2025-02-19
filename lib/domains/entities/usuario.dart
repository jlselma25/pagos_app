

class Usuario {
  final String email;  
  final String password;
  final String token;
  final int id;
 

  Usuario( {
    required this.email,     
    required this.password,   
    required this.token,
    required this.id,
  
    }); 


  factory Usuario.fromJsonMap(Map<String,dynamic>json) =>
    Usuario(
      email: json['email'] ?? '',       
      password: json['password'] ?? '',
      id:json['id'],
      token: json['token'] ?? '',
      
    );




}