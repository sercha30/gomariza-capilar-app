class ServiceListResponse {
  ServiceListResponse({
    required this.id,
    required this.nombre,
    required this.foto,
  });
  late final String id;
  late final String nombre;
  late final String foto;

  ServiceListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['foto'] = foto;
    return _data;
  }
}
