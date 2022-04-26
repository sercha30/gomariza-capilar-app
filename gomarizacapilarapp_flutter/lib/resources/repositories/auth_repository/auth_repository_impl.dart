import 'dart:convert';

import 'package:flutter_gomariza_capilar_app/models/auth/login/login_response.dart';
import 'package:flutter_gomariza_capilar_app/models/auth/login/login_dto.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../models/auth/register/register_dto.dart';
import '../../../models/auth/register/register_response.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(
        Uri.parse(Constants.API_BASE_URL + '/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));

    if (response.statusCode == Constants.RESPONSE_CREATED) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al hacer login');
    }
  }

  @override
  Future<RegisterResponse> register(
      RegisterDto registerDto, String imagePath) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };

    var uri = Uri.parse(Constants.API_BASE_URL + 'auth/register/cliente');

    var body = jsonEncode({
      'nombre': registerDto.nombre,
      'apellidos': registerDto.apellidos,
      'email': registerDto.email,
      'password': registerDto.password,
      'password2': registerDto.password2,
      'fechaNacimiento': registerDto.fechaNacimiento,
    });

    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromString('usuario', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('foto', imagePath,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Failed to register');
    }
  }
}
