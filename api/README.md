# API 폴더

고려대학교 동아리 관리 시스템의 API 관련 파일들이 모여있는 폴더입니다.

## 📁 파일 구조

```
api/
├── README.md                    # 이 파일 (API 폴더 설명)
├── api_endpoints.dart           # API 엔드포인트 정의
├── api_service.dart             # API 서비스 클래스
└── api_usage_examples.dart     # API 사용 예시
```

## 📋 파일 설명

### 1. `api_endpoints.dart`
- 모든 API 엔드포인트를 상수로 정의
- 헤더, 상태 코드, 에러 메시지 정의
- URL 생성 메서드 제공

**사용법:**
```dart
import 'api/api_endpoints.dart';

// URL 가져오기
String loginUrl = ApiEndpoints.getLoginUrl();
String usersUrl = ApiEndpoints.getUsersUrl();

// 헤더 가져오기
Map<String, String> headers = ApiHeaders.withAuth(token);
```

### 2. `api_service.dart`
- 모든 API 호출을 관리하는 중앙 집중식 서비스
- 에러 처리 및 응답 파싱 포함
- Singleton 패턴으로 구현

**사용법:**
```dart
import 'api/api_service.dart';

final apiService = ApiService();

// 로그인
final result = await apiService.login(username, password);
if (result['success']) {
  // 성공 처리
} else {
  // 에러 처리
}
```

### 3. `api_usage_examples.dart`
- 각 API 사용 방법에 대한 예시 코드
- 실제 Flutter 위젯에서 사용하는 방법 포함
- 에러 처리 방법도 포함

## 🚀 사용 방법

### 1. Flutter 프로젝트에서 import
```dart
import 'api/api_endpoints.dart';
import 'api/api_service.dart';
```

### 2. API 서비스 사용
```dart
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService _apiService = ApiService();

  Future<void> _login() async {
    final result = await _apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (result['success']) {
      // 로그인 성공
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboard()),
      );
    } else {
      // 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }
}
```

## 🔧 설정

### 서버 URL 변경
`api_endpoints.dart` 파일에서 `baseUrl`을 수정하세요:

```dart
static const String baseUrl = 'http://your-server-ip:5000';
```

### 에러 메시지 커스터마이징
`api_endpoints.dart` 파일의 `ApiErrorMessages` 클래스에서 메시지를 수정할 수 있습니다.

## 📝 API 목록

| API | 메서드 | 설명 | 인증 필요 |
|-----|--------|------|-----------|
| 로그인 | POST | 사용자 인증 | ❌ |
| 회원가입 | POST | 새 사용자 등록 | ❌ |
| 비밀번호 재설정 | POST | 임시 비밀번호 발송 | ❌ |
| 사용자 목록 | GET | 모든 사용자 조회 | ✅ |
| 운영진 권한 부여 | POST | 관리자 권한 부여 | ✅ |
| 부원 권한으로 변경 | POST | 일반 사용자로 변경 | ✅ |
| 사용자 삭제 | DELETE | 사용자 계정 삭제 | ✅ |
| 비밀번호 변경 | POST | 비밀번호 변경 | ✅ |
| 서버 상태 확인 | GET | 서버 상태 확인 | ❌ |

## 🎯 장점

1. **중앙 집중화**: 모든 API 호출이 한 곳에서 관리됨
2. **재사용성**: 여러 화면에서 동일한 API 서비스 사용 가능
3. **유지보수성**: API 변경 시 한 곳만 수정하면 됨
4. **에러 처리**: 일관된 에러 처리 방식
5. **타입 안전성**: Dart의 타입 시스템 활용

## 🔄 업데이트

새로운 API가 추가되면:
1. `api_endpoints.dart`에 엔드포인트 추가
2. `api_service.dart`에 메서드 추가
3. `api_usage_examples.dart`에 사용 예시 추가

