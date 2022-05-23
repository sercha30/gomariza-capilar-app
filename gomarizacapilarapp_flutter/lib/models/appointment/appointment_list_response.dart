class AppointmentListResponse {
  AppointmentListResponse({
    required this.id,
    required this.nombreProfesional,
    required this.apellidosProfesional,
    required this.nombreServicio,
    required this.fotoProfesional,
    required this.fechaCita,
    required this.duracion,
  });
  late final String id;
  late final String nombreProfesional;
  late final String apellidosProfesional;
  late final String nombreServicio;
  late final String fotoProfesional;
  late final List<dynamic> fechaCita;
  late final List<dynamic> duracion;

  AppointmentListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreProfesional = json['nombreProfesional'];
    apellidosProfesional = json['apellidosProfesional'];
    nombreServicio = json['nombreServicio'];
    fotoProfesional = json['fotoProfesional'];
    fechaCita = json['fechaCita'];
    duracion = json['duracion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombreProfesional'] = nombreProfesional;
    _data['apellidosProfesional'] = apellidosProfesional;
    _data['nombreServicio'] = nombreServicio;
    _data['fotoProfesional'] = fotoProfesional;
    _data['fechaCita'] = fechaCita;
    _data['duracion'] = duracion;
    return _data;
  }
}
