// API 사용 예시
// Flutter에서 ApiService를 사용하는 방법들

import 'api_service.dart';

class ApiUsageExamples {
  final ApiService _apiService = ApiService();

  // 1. 로그인 예시
  Future<void> loginExample() async {
    final result = await _apiService.login('2020123456', 'password123');
    
    if (result['success']) {
      print('로그인 성공: ${result['message']}');
      final user = result['data']['user'];
      final token = result['data']['token'];
      
      // 토큰과 사용자 정보 저장
      // await saveUserData(user, token);
    } else {
      print('로그인 실패: ${result['message']}');
    }
  }

  // 2. 회원가입 예시
  Future<void> registerExample() async {
    final result = await _apiService.register(
      username: '2020123456',
      name: '홍길동',
      email: 'hong@korea.ac.kr',
      password: 'password123',
      phone: '01012345678',
    );
    
    if (result['success']) {
      print('회원가입 성공: ${result['message']}');
    } else {
      print('회원가입 실패: ${result['message']}');
      if (result['errors'] != null) {
        print('에러 상세: ${result['errors']}');
      }
    }
  }

  // 3. 사용자 목록 조회 예시
  Future<void> getUsersExample(String token) async {
    final result = await _apiService.getUsers(token);
    
    if (result['success']) {
      final users = result['data']['users'];
      print('사용자 수: ${users.length}');
      
      for (var user in users) {
        print('이름: ${user['name']}, 학번: ${user['username']}, 역할: ${user['role']}');
      }
    } else {
      print('사용자 목록 조회 실패: ${result['message']}');
    }
  }

  // 4. 운영진 권한 부여 예시
  Future<void> grantAdminExample(String token, String targetUsername) async {
    final result = await _apiService.grantAdmin(token, targetUsername);
    
    if (result['success']) {
      print('운영진 권한 부여 성공: ${result['message']}');
      final user = result['data']['user'];
      print('변경된 사용자: ${user['name']} (${user['role']})');
    } else {
      print('운영진 권한 부여 실패: ${result['message']}');
    }
  }

  // 5. 부원 권한으로 변경 예시
  Future<void> revokeAdminExample(String token, String targetUsername) async {
    final result = await _apiService.revokeAdmin(token, targetUsername);
    
    if (result['success']) {
      print('부원 권한으로 변경 성공: ${result['message']}');
      final user = result['data']['user'];
      print('변경된 사용자: ${user['name']} (${user['role']})');
    } else {
      print('부원 권한으로 변경 실패: ${result['message']}');
    }
  }

  // 6. 사용자 삭제 예시
  Future<void> deleteUserExample(String token, String userId) async {
    final result = await _apiService.deleteUser(token, userId);
    
    if (result['success']) {
      print('사용자 삭제 성공: ${result['message']}');
    } else {
      print('사용자 삭제 실패: ${result['message']}');
    }
  }

  // 7. 비밀번호 변경 예시
  Future<void> changePasswordExample(String token, String currentPassword, String newPassword) async {
    final result = await _apiService.changePassword(token, currentPassword, newPassword);
    
    if (result['success']) {
      print('비밀번호 변경 성공: ${result['message']}');
    } else {
      print('비밀번호 변경 실패: ${result['message']}');
    }
  }

  // 8. 비밀번호 재설정 예시
  Future<void> resetPasswordExample() async {
    final result = await _apiService.resetPassword('2020123456', 'hong@korea.ac.kr');
    
    if (result['success']) {
      print('비밀번호 재설정 성공: ${result['message']}');
    } else {
      print('비밀번호 재설정 실패: ${result['message']}');
    }
  }

  // 9. 서버 상태 확인 예시
  Future<void> checkHealthExample() async {
    final result = await _apiService.checkHealth();
    
    if (result['success']) {
      print('서버 상태: ${result['message']}');
    } else {
      print('서버 연결 실패: ${result['message']}');
    }
  }

  // 10. 에러 처리 예시
  void handleApiError(Map<String, dynamic> result) {
    if (!result['success']) {
      switch (result['message']) {
        case '네트워크 연결을 확인해주세요.':
          // 네트워크 연결 확인 안내
          print('인터넷 연결을 확인해주세요.');
          break;
        case '로그인이 필요합니다.':
          // 로그인 페이지로 이동
          print('다시 로그인해주세요.');
          break;
        case '권한이 없습니다.':
          // 권한 없음 안내
          print('관리자 권한이 필요합니다.');
          break;
        default:
          // 일반적인 에러 메시지 표시
          print('오류: ${result['message']}');
      }
    }
  }
}

// 실제 Flutter 위젯에서 사용하는 예시
/*
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final result = await _apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (result['success']) {
      // 로그인 성공 시 관리자 대시보드로 이동
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _usernameController),
          TextField(controller: _passwordController),
          ElevatedButton(
            onPressed: _login,
            child: Text('로그인'),
          ),
        ],
      ),
    );
  }
}
*/
