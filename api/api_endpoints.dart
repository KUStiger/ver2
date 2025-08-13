// API 엔드포인트 정의
// 고려대학교 동아리 관리 시스템 API

class ApiEndpoints {
  // 기본 URL
  static const String baseUrl = 'http://192.168.1.33:5000';
  
  // 인증 관련 API
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String resetPassword = '/api/reset-password';
  static const String changePassword = '/api/change-password';
  
  // 사용자 관리 API
  static const String users = '/api/users';
  static const String grantAdmin = '/api/grant-admin';
  static const String revokeAdmin = '/api/revoke-admin';
  static const String deleteUser = '/api/users/'; // + userId
  
  // 시스템 API
  static const String health = '/api/health';
  
  // 전체 URL 생성 메서드들
  static String getLoginUrl() => '$baseUrl$login';
  static String getRegisterUrl() => '$baseUrl$register';
  static String getResetPasswordUrl() => '$baseUrl$resetPassword';
  static String getChangePasswordUrl() => '$baseUrl$changePassword';
  static String getUsersUrl() => '$baseUrl$users';
  static String getGrantAdminUrl() => '$baseUrl$grantAdmin';
  static String getRevokeAdminUrl() => '$baseUrl$revokeAdmin';
  static String getDeleteUserUrl(String userId) => '$baseUrl$deleteUser$userId';
  static String getHealthUrl() => '$baseUrl$health';
}

// API 요청 헤더 정의
class ApiHeaders {
  static const Map<String, String> jsonContent = {
    'Content-Type': 'application/json',
  };
  
  static Map<String, String> withAuth(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }
}

// API 응답 상태 코드
class ApiStatusCodes {
  static const int success = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
}

// API 에러 메시지
class ApiErrorMessages {
  static const String networkError = '네트워크 연결을 확인해주세요.';
  static const String serverError = '서버 오류가 발생했습니다.';
  static const String unauthorized = '로그인이 필요합니다.';
  static const String forbidden = '권한이 없습니다.';
  static const String notFound = '요청한 데이터를 찾을 수 없습니다.';
  static const String invalidData = '입력 데이터가 올바르지 않습니다.';
}
