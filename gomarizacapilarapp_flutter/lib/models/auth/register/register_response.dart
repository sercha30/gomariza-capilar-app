class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.email,
    required this.rol,
  });
  late final String id;
  late final String nombre;
  late final String foto;
  late final String email;
  late final String rol;

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    foto = json['foto'];
    email = json['email'];
    rol = json['rol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['foto'] = foto;
    _data['email'] = email;
    _data['rol'] = rol;
    return _data;
  }
}
