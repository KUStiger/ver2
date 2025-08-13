import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';

// API 서비스 클래스
// 모든 API 호출을 관리하는 중앙 집중식 서비스
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // 로그인
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getLoginUrl()),
        headers: ApiHeaders.jsonContent,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 회원가입
  Future<Map<String, dynamic>> register({
    required String username,
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getRegisterUrl()),
        headers: ApiHeaders.jsonContent,
        body: jsonEncode({
          'username': username,
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 비밀번호 재설정
  Future<Map<String, dynamic>> resetPassword(String username, String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getResetPasswordUrl()),
        headers: ApiHeaders.jsonContent,
        body: jsonEncode({
          'username': username,
          'email': email,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 사용자 목록 조회
  Future<Map<String, dynamic>> getUsers(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.getUsersUrl()),
        headers: ApiHeaders.withAuth(token),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 운영진 권한 부여
  Future<Map<String, dynamic>> grantAdmin(String token, String targetUsername) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getGrantAdminUrl()),
        headers: ApiHeaders.withAuth(token),
        body: jsonEncode({
          'targetUsername': targetUsername,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 부원 권한으로 변경
  Future<Map<String, dynamic>> revokeAdmin(String token, String targetUsername) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getRevokeAdminUrl()),
        headers: ApiHeaders.withAuth(token),
        body: jsonEncode({
          'targetUsername': targetUsername,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 사용자 삭제
  Future<Map<String, dynamic>> deleteUser(String token, String userId) async {
    try {
      final response = await http.delete(
        Uri.parse(ApiEndpoints.getDeleteUserUrl(userId)),
        headers: ApiHeaders.withAuth(token),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 비밀번호 변경
  Future<Map<String, dynamic>> changePassword(
    String token,
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.getChangePasswordUrl()),
        headers: ApiHeaders.withAuth(token),
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 서버 상태 확인
  Future<Map<String, dynamic>> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.getHealthUrl()),
        headers: ApiHeaders.jsonContent,
      );

      return _handleResponse(response);
    } catch (e) {
      return {'success': false, 'message': ApiErrorMessages.networkError};
    }
  }

  // 응답 처리 헬퍼 메서드
  Map<String, dynamic> _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);
    
    switch (response.statusCode) {
      case ApiStatusCodes.success:
      case ApiStatusCodes.created:
        return {
          'success': true,
          'data': body,
          'message': body['message'] ?? '성공',
        };
      
      case ApiStatusCodes.badRequest:
        return {
          'success': false,
          'message': body['message'] ?? ApiErrorMessages.invalidData,
          'errors': body['errors'],
        };
      
      case ApiStatusCodes.unauthorized:
        return {
          'success': false,
          'message': ApiErrorMessages.unauthorized,
        };
      
      case ApiStatusCodes.forbidden:
        return {
          'success': false,
          'message': ApiErrorMessages.forbidden,
        };
      
      case ApiStatusCodes.notFound:
        return {
          'success': false,
          'message': ApiErrorMessages.notFound,
        };
      
      case ApiStatusCodes.serverError:
      default:
        return {
          'success': false,
          'message': ApiErrorMessages.serverError,
        };
    }
  }
}
