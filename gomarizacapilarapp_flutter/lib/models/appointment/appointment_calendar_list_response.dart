class AppointmentCalendarListResponse {
  AppointmentCalendarListResponse({
    required this.id,
    required this.nombreServicio,
    required this.de,
    required this.a,
  });
  late final String id;
  late final String nombreServicio;
  late final List<dynamic> de;
  late final List<dynamic> a;

  AppointmentCalendarListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombreServicio = json['nombreServicio'];
    de = json['de'];
    a = json['a'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombreServicio'] = nombreServicio;
    _data['de'] = de;
    _data['a'] = a;
    return _data;
  }
}
