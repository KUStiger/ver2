# API 문서

고려대학교 동아리 관리 시스템의 모든 API 엔드포인트입니다.

## 🔗 기본 URL
```
http://localhost:5000
```

## 📋 API 목록

### 1. 서버 상태 확인
**GET** `/api/health`

서버가 정상적으로 실행 중인지 확인합니다.

**응답:**
```json
{
  "message": "서버가 정상적으로 실행 중입니다."
}
```

---

### 2. 회원가입
**POST** `/api/register`

새로운 사용자를 등록합니다.

**요청 본문:**
```json
{
  "username": "2020123456",    // 학번 (10자리 숫자)
  "name": "홍길동",            // 이름
  "email": "hong@korea.ac.kr", // 이메일
  "password": "Password123!",   // 비밀번호 (보안 정책 참조)
  "phone": "01012345678",      // 전화번호 (10-11자리)
  "securityQuestion": "내가 가장 좋아하는 음식은?", // 보안 질문
  "securityAnswer": "김치찌개", // 보안 질문 답변
  "privacyAgreement": true     // 개인정보 수집 및 이용 동의 (필수)
}
```

**비밀번호 보안 정책:**
- 최소 8자 이상
- 대문자, 소문자, 숫자, 특수문자 포함
- 같은 문자가 3번 이상 연속되면 안됨
- 키보드 패턴 사용 불가 (123, qwe, asd 등)

**응답:**
```json
{
  "message": "회원가입이 완료되었습니다."
}
```

**에러:**
- `400`: 입력 데이터 오류
- `400`: 이미 존재하는 학번
- `400`: 개인정보 수집 및 이용에 동의해주세요

---

### 3. 로그인
**POST** `/api/login`

사용자 인증 및 JWT 토큰 발급

**요청 본문:**
```json
{
  "username": "2020123456",  // 학번
  "password": "password123"   // 비밀번호
}
```

**응답:**
```json
{
  "message": "로그인 성공",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "username": "2020123456",
    "name": "홍길동",
    "email": "hong@korea.ac.kr",
    "role": "member",
    "phone": "01012345678"
  }
}
```

**에러:**
- `401`: 잘못된 사용자명 또는 비밀번호

---

### 4. 비밀번호 재설정
**POST** `/api/reset-password`

보안 질문을 통해 임시 비밀번호를 발송합니다.

**요청 본문:**
```json
{
  "username": "2020123456",     // 학번
  "name": "홍길동",             // 이름
  "email": "hong@korea.ac.kr",  // 이메일
  "securityAnswer": "김치찌개"   // 보안 질문 답변
}
```

**응답:**
```json
{
  "message": "임시 비밀번호가 이메일로 전송되었습니다."
}
```

**에러:**
- `400`: 입력 데이터 오류
- `404`: 입력하신 정보가 일치하지 않습니다

---

### 5. 보안 질문 목록
**GET** `/api/security-questions`

회원가입 시 선택할 수 있는 보안 질문 목록을 제공합니다.

**응답:**
```json
{
  "securityQuestions": [
    { "id": 1, "question": "내가 가장 좋아하는 음식은?" },
    { "id": 2, "question": "내가 태어난 도시는?" },
    { "id": 3, "question": "내가 가장 좋아하는 색깔은?" },
    { "id": 4, "question": "내가 키운 첫 번째 반려동물의 이름은?" },
    { "id": 5, "question": "내가 가장 좋아하는 영화는?" },
    { "id": 6, "question": "내가 졸업한 초등학교 이름은?" },
    { "id": 7, "question": "내가 가장 좋아하는 계절은?" },
    { "id": 8, "question": "내가 가장 좋아하는 음악 장르는?" },
    { "id": 9, "question": "내가 가장 좋아하는 운동은?" },
    { "id": 10, "question": "내가 가장 좋아하는 책은?" }
  ]
}
```

---

### 6. 개인정보 처리방침
**GET** `/api/privacy-policy`

개인정보 수집 및 이용 동의 내용을 제공합니다.

**응답:**
```json
{
  "title": "개인정보 수집 및 이용 동의",
  "content": "1. 수집하는 개인정보 항목...",
  "version": "1.0",
  "lastUpdated": "2024-01-01"
}
```

---

### 5. 운영진 권한 부여
**POST** `/api/grant-admin`

사용자에게 운영진 권한을 부여합니다. (관리자 권한 필요)

**헤더:**
```
Authorization: Bearer <JWT_TOKEN>
```

**요청 본문:**
```json
{
  "targetUsername": "2020123456"  // 권한을 부여할 사용자의 학번
}
```

**응답:**
```json
{
  "message": "운영진 권한이 부여되었습니다.",
  "user": {
    "id": 1,
    "username": "2020123456",
    "name": "홍길동",
    "email": "hong@korea.ac.kr",
    "role": "admin",
    "phone": "01012345678"
  }
}
```

**에러:**
- `401`: 인증 토큰 없음
- `403`: 관리자 권한 없음
- `404`: 사용자를 찾을 수 없음
- `400`: 이미 운영진 권한을 가진 사용자

---

### 6. 부원 권한으로 변경
**POST** `/api/revoke-admin`

운영진을 부원 권한으로 변경합니다. (관리자 권한 필요)

**헤더:**
```
Authorization: Bearer <JWT_TOKEN>
```

**요청 본문:**
```json
{
  "targetUsername": "2020123456"  // 권한을 변경할 사용자의 학번
}
```

**응답:**
```json
{
  "message": "부원 권한으로 변경되었습니다.",
  "user": {
    "id": 1,
    "username": "2020123456",
    "name": "홍길동",
    "email": "hong@korea.ac.kr",
    "role": "member",
    "phone": "01012345678"
  }
}
```

**에러:**
- `401`: 인증 토큰 없음
- `403`: 관리자 권한 없음
- `404`: 사용자를 찾을 수 없음
- `400`: 이미 부원 권한을 가진 사용자

---

### 7. 사용자 목록 조회
**GET** `/api/users`

모든 사용자 목록을 조회합니다. (관리자 권한 필요)

**헤더:**
```
Authorization: Bearer <JWT_TOKEN>
```

### 8. 비밀번호 변경
**POST** `/api/change-password`

사용자의 비밀번호를 변경합니다.

**요청 본문:**
```json
{
  "currentPassword": "oldpassword",  // 현재 비밀번호
  "newPassword": "NewPassword123!"   // 새 비밀번호 (보안 정책 참조)
}
```

**비밀번호 보안 정책:**
- 최소 8자 이상
- 대문자, 소문자, 숫자, 특수문자 포함
- 같은 문자가 3번 이상 연속되면 안됨
- 키보드 패턴 사용 불가 (123, qwe, asd 등)

**응답:**
```json
{
  "message": "비밀번호가 변경되었습니다."
}
```

**에러:**
- `401`: 잘못된 현재 비밀번호
- `400`: 새 비밀번호가 현재 비밀번호와 같음