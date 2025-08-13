# API 요약표

## 📋 모든 API 목록

| 번호 | 메서드 | 엔드포인트 | 설명 | 인증 필요 |
|------|--------|------------|------|-----------|
| 1 | GET | `/api/health` | 서버 상태 확인 | ❌ |
| 2 | POST | `/api/register` | 회원가입 | ❌ |
| 3 | POST | `/api/login` | 로그인 | ❌ |
| 4 | POST | `/api/reset-password` | 비밀번호 재설정 | ❌ |
| 5 | POST | `/api/grant-admin` | 운영진 권한 부여 | ✅ |
| 6 | POST | `/api/revoke-admin` | 부원 권한으로 변경 | ✅ |
| 7 | GET | `/api/users` | 사용자 목록 조회 | ✅ |
| 8 | POST | `/api/change-password` | 비밀번호 변경 | ✅ |
| 9 | DELETE | `/api/users/:id` | 사용자 삭제 | ✅ |

## 🔐 권한별 API 접근

### 모든 사용자 (인증 불필요)
- ✅ `/api/health` - 서버 상태 확인
- ✅ `/api/register` - 회원가입
- ✅ `/api/login` - 로그인
- ✅ `/api/reset-password` - 비밀번호 재설정

### 관리자만 (인증 필요)
- 🔒 `/api/grant-admin` - 운영진 권한 부여
- 🔒 `/api/revoke-admin` - 부원 권한으로 변경
- 🔒 `/api/users` - 사용자 목록 조회
- 🔒 `/api/change-password` - 비밀번호 변경
- 🔒 `/api/users/:id` - 사용자 삭제

## 📱 Flutter에서 사용하는 API

### 로그인 화면
- `POST /api/login` - 로그인
- `POST /api/register` - 회원가입
- `POST /api/reset-password` - 비밀번호 찾기

### 관리자 대시보드
- `GET /api/users` - 사용자 목록 조회
- `POST /api/grant-admin` - 운영진 권한 부여
- `POST /api/revoke-admin` - 부원 권한으로 변경
- `DELETE /api/users/:id` - 사용자 삭제

## 🚨 주요 에러 코드

| 코드 | 의미 | 해결 방법 |
|------|------|-----------|
| 200 | 성공 | - |
| 201 | 생성 성공 | - |
| 400 | 잘못된 요청 | 입력 데이터 확인 |
| 401 | 인증 실패 | 로그인 필요 |
| 403 | 권한 없음 | 관리자 권한 필요 |
| 404 | 리소스 없음 | 존재하지 않는 데이터 |
| 500 | 서버 오류 | 서버 재시작 |

## 💡 사용 팁

1. **JWT 토큰**: 로그인 후 받은 토큰을 헤더에 포함
   ```
   Authorization: Bearer <token>
   ```

2. **학번 형식**: 10자리 숫자만 허용
   ```
   "2020123456" ✅
   "202012345" ❌ (9자리)
   "20201234567" ❌ (11자리)
   ```

3. **비밀번호**: 최소 6자 이상
   ```
   "password123" ✅
   "123" ❌ (3자리)
   ```

4. **전화번호**: 10-11자리 숫자
   ```
   "01012345678" ✅
   "0101234567" ✅
   "010123456" ❌ (9자리)
   ```
