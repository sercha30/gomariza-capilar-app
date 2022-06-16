import 'dart:convert';

import 'package:flutter_gomariza_capilar_app/models/service/service_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/models/service/service_list_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';

import '../../../utils/constants/constants.dart';
import '../../../utils/preferences/preferences_utils.dart';
import 'package:http/http.dart' as http;

class ServiceRepositoryImpl extends ServiceRepository {
  final headers = {
    'Authorization':
        'Bearer ${PreferenceUtils.getString(Constants.BEARER_TOKEN)}'
  };

  @override
  Future<List<ServiceListResponse>> getServicesList() async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL + '/servicio/serviciosList'),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return List.from(json.decode(response.body))
          .map((e) => ServiceListResponse.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to get service list');
    }
  }

  @override
  Future<ServiceDetailResponse> getServiceDetail(String idService) async {
    final response = await http.get(
        Uri.parse(Constants.API_BASE_URL + '/servicio/' + idService),
        headers: headers);

    if (response.statusCode == Constants.RESPONSE_OK) {
      return ServiceDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get service detail');
    }
  }
}
