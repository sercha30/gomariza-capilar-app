import 'package:flutter_gomariza_capilar_app/models/service/service_list_response.dart';

abstract class ServiceRepository {
  Future<List<ServiceListResponse>> getServicesList();
}
