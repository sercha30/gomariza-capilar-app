class MeResponse {
  MeResponse({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.email,
    required this.foto,
    required this.rol,
  });
  late final String id;
  late final String nombre;
  late final String apellidos;
  late final String email;
  late final String foto;
  late final String rol;

  MeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    email = json['email'];
    foto = json['foto'];
    rol = json['rol'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['apellidos'] = apellidos;
    _data['email'] = email;
    _data['foto'] = foto;
    _data['rol'] = rol;
    return _data;
  }
}
