class AppointmentDto {
  String? servicioId;
  String? fechaCita;

  AppointmentDto({this.servicioId, this.fechaCita});

  AppointmentDto.fromJson(Map<String, dynamic> json) {
    servicioId = json['servicioId'];
    fechaCita = json['fechaCita'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['servicioId'] = servicioId;
    data['fechaCita'] = fechaCita;
    return data;
  }
}
