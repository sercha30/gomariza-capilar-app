class ServiceDetailResponse {
  ServiceDetailResponse({
    required this.id,
    required this.nombre,
    required this.foto,
    required this.descripcion,
    required this.nombreProfesional,
    required this.duracion,
    required this.precio,
  });
  late final String id;
  late final String nombre;
  late final String foto;
  late final String descripcion;
  late final String nombreProfesional;
  late final String duracion;
  late final String precio;

  ServiceDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    foto = json['foto'];
    descripcion = json['descripcion'];
    nombreProfesional = json['nombreProfesional'];
    duracion = json['duracion'];
    precio = json['precio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['foto'] = foto;
    _data['descripcion'] = descripcion;
    _data['nombreProfesional'] = nombreProfesional;
    _data['duracion'] = duracion;
    _data['precio'] = precio;
    return _data;
  }
}
