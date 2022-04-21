import '../../../models/auth/login/login_dto.dart';
import '../../../models/auth/login/login_response.dart';
import '../../../models/auth/register/register_dto.dart';
import '../../../models/auth/register/register_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<RegisterResponse> register(RegisterDto registerDto, String imagePath);
}
