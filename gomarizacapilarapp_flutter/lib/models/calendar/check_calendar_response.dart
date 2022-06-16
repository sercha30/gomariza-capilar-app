import 'dart:convert';

Map<String, List<CheckCalendarResponse>> checkCalendarResponseFromJson(
        String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, List<CheckCalendarResponse>>(
            k,
            List<CheckCalendarResponse>.from(
                v.map((x) => CheckCalendarResponse.fromJson(x)))));

String checkCalendarResponseToJson(
        Map<String, List<CheckCalendarResponse>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

class CheckCalendarResponse {
  CheckCalendarResponse({
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
  });

  List<int> fecha;
  List<int> horaInicio;
  List<int> horaFin;

  factory CheckCalendarResponse.fromJson(Map<String, dynamic> json) =>
      CheckCalendarResponse(
        fecha: List<int>.from(json["fecha"].map((x) => x)),
        horaInicio: List<int>.from(json["horaInicio"].map((x) => x)),
        horaFin: List<int>.from(json["horaFin"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fecha": List<dynamic>.from(fecha.map((x) => x)),
        "horaInicio": List<dynamic>.from(horaInicio.map((x) => x)),
        "horaFin": List<dynamic>.from(horaFin.map((x) => x)),
      };
}
