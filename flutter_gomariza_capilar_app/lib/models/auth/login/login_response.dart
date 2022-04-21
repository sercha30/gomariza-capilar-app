class LoginResponse {
  LoginResponse({
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.foto,
    required this.rol,
    required this.token,
  });
  late final String nombre;
  late final String apellidos;
  late final String email;
  late final String foto;
  late final String rol;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    email = json['email'];
    foto = json['foto'];
    rol = json['rol'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['apellidos'] = apellidos;
    _data['email'] = email;
    _data['foto'] = foto;
    _data['rol'] = rol;
    _data['token'] = token;
    return _data;
  }
}
