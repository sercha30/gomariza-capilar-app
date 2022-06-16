class AppointmentDetailResponse {
  AppointmentDetailResponse({
    required this.id,
    required this.nombreServicio,
    required this.de,
    required this.a,
    required this.apellidosProfesional,
    required this.lat,
    required this.lng,
  });
  late final String id;
  late final String nombreServicio;
  late final List<dynamic> de;
  late final List<dynamic> a;
  late final String apellidosProfesional;
  late final String lat;
  late final String lng;

  AppointmentDetailResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreServicio = json['nombreServicio'];
    de = json['de'];
    a = json['a'];
    apellidosProfesional = json['apellidosProfesional'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombreServicio'] = nombreServicio;
    _data['de'] = de;
    _data['a'] = a;
    _data['apellidosProfesional'] = apellidosProfesional;
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}
