# 🏨 HotelMatch - AI 기반 여행 목적별 호텔 추천 서비스

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/downloads/)
[![FastAPI](https://img.shields.io/badge/FastAPI-0.100+-green.svg)](https://fastapi.tiangolo.com/)
[![React](https://img.shields.io/badge/React-18+-61DAFB.svg)](https://reactjs.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7.0+-green.svg)](https://www.mongodb.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

> AI 기반 리뷰 분석으로 여행 목적에 맞는 최적의 호텔을 추천하는 중립적인 플랫폼

## 📋 목차

- [프로젝트 소개](#-프로젝트-소개)
- [주요 기능](#-주요-기능)
- [기술 스택](#-기술-스택)
- [시스템 아키텍처](#-시스템-아키텍처)
- [시작하기](#-시작하기)
- [프로젝트 구조](#-프로젝트-구조)
- [API 문서](#-api-문서)
- [개발 로드맵](#-개발-로드맵)
- [기여하기](#-기여하기)
- [라이선스](#-라이선스)

---

## 🎯 프로젝트 소개

**HotelMatch**는 GPT-4o-mini를 활용한 AI 기반 호텔 추천 플랫폼입니다. 단순한 평점이 아닌, 여행 목적(비즈니스, 가족, 커플, 개인, 친구)에 맞는 깊이 있는 리뷰 분석을 제공합니다.

### 핵심 가치

- 🎯 **여행 목적별 맞춤 추천**: 비즈니스 출장과 가족 여행은 다릅니다
- 🤖 **AI 기반 리뷰 분석**: GPT-4o-mini로 수천 개의 리뷰를 분석
- 🔍 **중립적 통합 플랫폼**: 여러 예약 사이트의 리뷰를 통합 분석
- 📊 **데이터 기반 의사결정**: 통계와 인사이트로 최적의 선택 지원

### 차별화 요소

기존 호텔 추천 서비스와의 차이점:

| 구분 | 기존 서비스 | HotelMatch |
|------|------------|------------|
| 추천 방식 | 평점 기반 | 여행 목적별 AI 분석 |
| 리뷰 분석 | 최신순/평점순 나열 | LLM 기반 요약 및 인사이트 |
| 여행자 분류 | 없음 또는 수동 선택 | AI 자동 분류 (85% 정확도) |
| 정보 깊이 | 표면적 | 여행자 유형별 상세 분석 |

---

## ✨ 주요 기능

### MVP (Phase 1) - 3개월

- [x] **호텔 리뷰 크롤링**
  - 야놀자, 여기어때 (2개 플랫폼)
  - 서울 주요 호텔 100개
  - 호텔당 평균 50개 리뷰

- [x] **AI 기반 리뷰 분석**
  - 여행자 유형 자동 분류 (비즈니스/가족/커플/개인/친구)
  - 유형별 리뷰 요약 생성
  - 감성 분석 (긍정/중립/부정)
  - 항목별 평점 계산

- [x] **여행 목적별 추천**
  - 목적 기반 가중치 계산
  - 매칭 스코어 산출
  - 추천 이유 설명

- [x] **호텔 상세 정보**
  - 전체 요약
  - 여행자 유형별 평가
  - 장점/단점 분석
  - 리뷰 목록 (유형별 필터링)

- [x] **기본 검색 및 필터**
  - 위치, 날짜, 인원
  - 가격대, 최소 평점
  - 여행 목적 선택

### Phase 2 (예정) - 6개월

- [ ] 추가 도시 (부산, 제주)
- [ ] 추가 플랫폼 (Booking.com, Agoda)
- [ ] 실시간 가격 비교
- [ ] 가격 알림 기능
- [ ] 사용자 히스토리 기반 학습
- [ ] 협업 필터링 추천
- [ ] KoBERT 기반 자체 모델 (비용 절감)

### Phase 3 (장기) - 12개월+

- [ ] 이미지 분석
- [ ] Q&A 챗봇
- [ ] 개인화 대시보드
- [ ] 그룹 추천 (여러 명의 선호도 고려)
- [ ] B2B 서비스 (기업 출장 관리)

---

## 🛠 기술 스택

### Backend

```yaml
Language: Python 3.11+
Framework: FastAPI 0.100+
Database: MongoDB 7.0
Cache: Redis 7.0
AI/ML: OpenAI GPT-4o-mini
Async: asyncio, Motor (async MongoDB driver)
Crawling: Playwright
Validation: Pydantic v2
Task Queue: Celery (optional)
```

### Frontend

```yaml
Framework: React 18 + TypeScript
Build Tool: Vite
State Management: Zustand
Styling: Tailwind CSS
Charts: Recharts
HTTP Client: Axios
Routing: React Router v6
Data Fetching: React Query
```

### Infrastructure

```yaml
Containerization: Docker, Docker Compose
Web Server: Nginx
SSL: Let's Encrypt
CI/CD: GitHub Actions
Hosting: Railway (MVP) → AWS (Phase 2)
Monitoring: Sentry, Google Analytics
```

### Development Tools

```yaml
Code Quality: ESLint, Prettier, Black
Testing: pytest, Jest, React Testing Library
API Documentation: OpenAPI (Swagger)
Version Control: Git, GitHub
Project Management: GitHub Projects / Notion
```

---

## 🏗 시스템 아키텍처

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Frontend (React)                      │
│  - 검색 페이지 (여행 목적 선택)                          │
│  - 결과 리스트 (유형별 필터)                             │
│  - 호텔 상세 (유형별 리뷰 분석)                          │
└────────────────────┬────────────────────────────────────┘
                     │ HTTPS/REST API
                     ▼
┌─────────────────────────────────────────────────────────┐
│              Backend API (FastAPI)                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Hotel      │  │   Review     │  │    User      │  │
│  │   Service    │  │   Service    │  │   Service    │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│  ┌──────────────────────────────────────────────────┐  │
│  │         LLM Service (GPT-4o-mini)                │  │
│  │  - 여행자 유형 분류                               │  │
│  │  - 리뷰 요약 생성                                 │  │
│  │  - 감성 분석                                      │  │
│  └──────────────────────────────────────────────────┘  │
└────────────────────┬────────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        ▼            ▼            ▼
┌──────────────┐ ┌──────────┐ ┌──────────────┐
│   MongoDB    │ │  Redis   │ │  OpenAI API  │
│   (Main DB)  │ │  (Cache) │ │ (GPT-4o-mini)│
└──────────────┘ └──────────┘ └──────────────┘

┌─────────────────────────────────────────────────────────┐
│              Crawling Service (독립 프로세스)            │
│  - Playwright 기반 크롤러                                │
│  - 일일 배치 (cron)                                      │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

```
1. 사용자 검색 요청
   ↓
2. Backend: 여행 목적별 가중치 계산
   ↓
3. MongoDB: 호텔 데이터 조회
   ↓
4. Redis: 캐시된 요약 확인
   ↓
5. (캐시 없으면) LLM: 리뷰 요약 생성
   ↓
6. Backend: 매칭 스코어 계산 및 정렬
   ↓
7. Frontend: 결과 표시
```

---

## 🚀 시작하기

### Prerequisites

다음 소프트웨어가 설치되어 있어야 합니다:

```bash
- Python 3.11 이상
- Node.js 18 이상
- MongoDB 7.0 이상
- Redis 7.0 이상
- Docker & Docker Compose (권장)
```

### Installation

#### 1. 저장소 클론

```bash
git clone https://github.com/your-username/hotel-recommendation.git
cd hotel-recommendation
```

#### 2. 환경 변수 설정

**Backend (.env)**

```bash
cp backend/.env.example backend/.env
```

```env
# MongoDB
MONGODB_URI=mongodb://localhost:27017/hotel_recommendation

# Redis
REDIS_URL=redis://localhost:6379

# OpenAI
OPENAI_API_KEY=your-openai-api-key-here

# App Settings
APP_ENV=development
DEBUG=true
SECRET_KEY=your-secret-key-here

# CORS
CORS_ORIGINS=http://localhost:5173

# Crawling
CRAWL_INTERVAL_HOURS=24
MAX_CONCURRENT_CRAWLS=5
```

**Frontend (.env)**

```bash
cp frontend/.env.example frontend/.env
```

```env
VITE_API_BASE_URL=http://localhost:8000/api/v1
VITE_GA_TRACKING_ID=your-ga-id
```

#### 3. Docker로 실행 (권장)

```bash
# 모든 서비스 시작
docker-compose up -d

# 로그 확인
docker-compose logs -f

# 중지
docker-compose down
```

서비스 접속:
- Frontend: http://localhost:5173
- Backend API: http://localhost:8000
- API 문서: http://localhost:8000/docs

#### 4. 로컬 환경에서 실행

**Backend**

```bash
cd backend

# 가상환경 생성
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# 의존성 설치
pip install -r requirements.txt

# 데이터베이스 마이그레이션 (필요 시)
python -m app.scripts.init_db

# 서버 실행
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

**Frontend**

```bash
cd frontend

# 의존성 설치
npm install

# 개발 서버 실행
npm run dev
```

#### 5. 초기 데이터 수집 (선택)

```bash
cd backend

# 샘플 호텔 크롤링 (10개)
python -m app.scripts.crawl_sample

# 전체 호텔 크롤링 (100개, 시간 소요)
python -m app.scripts.crawl_all
```

---

## 📁 프로젝트 구조

```
hotel-recommendation/
├── backend/                    # FastAPI 백엔드
│   ├── app/
│   │   ├── api/               # API 엔드포인트
│   │   │   ├── v1/
│   │   │   │   ├── hotels.py
│   │   │   │   ├── reviews.py
│   │   │   │   └── users.py
│   │   │   └── dependencies.py
│   │   ├── core/              # 핵심 설정
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   ├── models/            # Pydantic 모델
│   │   │   ├── hotel.py
│   │   │   ├── review.py
│   │   │   └── user.py
│   │   ├── services/          # 비즈니스 로직
│   │   │   ├── hotel_service.py
│   │   │   ├── review_service.py
│   │   │   ├── llm_service.py
│   │   │   └── recommendation_service.py
│   │   ├── crawlers/          # 크롤링 모듈
│   │   │   ├── base.py
│   │   │   ├── yanolja.py
│   │   │   └── goodchoice.py
│   │   ├── database/          # DB 연결
│   │   │   ├── mongodb.py
│   │   │   └── redis.py
│   │   ├── schemas/           # Request/Response 스키마
│   │   ├── utils/             # 유틸리티
│   │   ├── tasks/             # 비동기 작업
│   │   └── main.py            # 앱 진입점
│   ├── tests/                 # 테스트
│   ├── requirements.txt
│   ├── Dockerfile
│   └── .env.example
│
├── frontend/                   # React 프론트엔드
│   ├── src/
│   │   ├── components/        # UI 컴포넌트
│   │   │   ├── common/
│   │   │   ├── hotel/
│   │   │   └── search/
│   │   ├── pages/             # 페이지
│   │   │   ├── HomePage.tsx
│   │   │   ├── SearchPage.tsx
│   │   │   ├── HotelDetailPage.tsx
│   │   │   └── NotFoundPage.tsx
│   │   ├── hooks/             # Custom Hooks
│   │   ├── services/          # API 서비스
│   │   ├── stores/            # Zustand 스토어
│   │   ├── types/             # TypeScript 타입
│   │   ├── utils/             # 유틸리티
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── public/
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── tailwind.config.js
│
├── docs/                       # 문서
│   ├── architecture/
│   ├── api/
│   ├── design/
│   └── deployment/
│
├── scripts/                    # 유틸리티 스크립트
│   ├── deploy.sh
│   ├── backup.sh
│   └── seed_data.py
│
├── docker-compose.yml          # Docker 구성
├── .gitignore
├── README.md
└── LICENSE
```

---

## 📚 API 문서

### Base URL

```
Development: http://localhost:8000/api/v1
Production: https://api.hotelmatch.com/api/v1
```

### 주요 엔드포인트

#### 1. 호텔 검색

```http
POST /api/v1/search
```

**Request Body:**

```json
{
  "city": "서울",
  "check_in": "2025-12-01",
  "check_out": "2025-12-03",
  "guests": 2,
  "travel_purpose": "business",
  "price_range": "medium",
  "min_rating": 4.0,
  "sort_by": "recommended"
}
```

**Response:**

```json
{
  "hotels": [
    {
      "hotel_id": "shilla-seoul",
      "name": "신라호텔 서울",
      "address": "서울특별시 중구 동호로 249",
      "rating": {
        "overall": 4.5,
        "by_traveler": {
          "business": 4.6,
          "count": 85
        }
      },
      "price_range": "high",
      "images": ["url1", "url2"],
      "match_score": 0.92,
      "why_recommended": "비즈니스 여행자들이 위치와 와이파이를 높이 평가했습니다"
    }
  ],
  "total": 25,
  "page": 1,
  "per_page": 10
}
```

#### 2. 호텔 상세 정보

```http
GET /api/v1/hotels/{hotel_id}?travel_purpose=business
```

**Response:**

```json
{
  "hotel_id": "shilla-seoul",
  "name": "신라호텔 서울",
  "description": "...",
  "rating": {
    "overall": 4.5,
    "location": 4.7,
    "cleanliness": 4.6
  },
  "rating_by_traveler": {
    "business": {
      "overall": 4.6,
      "count": 85
    }
  },
  "summaries": {
    "overall": {
      "summary": "전체 요약...",
      "pros": ["장점1", "장점2", "장점3"],
      "cons": ["단점1", "단점2"]
    },
    "business": {
      "summary": "비즈니스 여행자 요약...",
      "pros": ["위치 우수", "와이파이 빠름"],
      "cons": ["주차비 비쌈"],
      "key_points": {
        "location": "역에서 도보 5분",
        "wifi": "업무하기 좋은 속도"
      }
    }
  },
  "platforms": {
    "yanolja": {
      "url": "https://...",
      "price": 250000
    }
  }
}
```

#### 3. 리뷰 목록

```http
GET /api/v1/hotels/{hotel_id}/reviews?traveler_type=business&page=1
```

**Response:**

```json
{
  "reviews": [
    {
      "review_id": "abc123",
      "traveler_type": "business",
      "rating": 4.5,
      "content": "출장으로 방문했는데...",
      "sentiment": "positive",
      "review_date": "2025-10-15T00:00:00Z"
    }
  ],
  "total": 85,
  "page": 1,
  "per_page": 20
}
```

### 전체 API 문서

개발 서버 실행 후 다음 주소에서 확인:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

---

## 🗺 개발 로드맵

### ✅ Phase 1: MVP (완료 예정: 2026년 2월)

- [x] 프로젝트 설계 및 문서화
- [ ] Backend API 개발
  - [ ] 호텔 검색 API
  - [ ] 호텔 상세 API
  - [ ] 리뷰 분석 API
- [ ] Frontend 개발
  - [ ] 검색 페이지
  - [ ] 결과 리스트
  - [ ] 호텔 상세 페이지
- [ ] LLM 통합
  - [ ] 여행자 유형 분류
  - [ ] 리뷰 요약 생성
- [ ] 크롤링 시스템
  - [ ] 야놀자 크롤러
  - [ ] 여기어때 크롤러
- [ ] 배포
  - [ ] Docker 환경 구성
  - [ ] Railway 배포
  - [ ] CI/CD 구축

**목표 지표:**
- 서울 호텔 100개
- 리뷰 5,000개 이상
- MAU 1,000명
- 전환율 10%

### 🔄 Phase 2: 기능 확장 (2026년 3-5월)

- [ ] 데이터 확장
  - [ ] 부산, 제주 추가
  - [ ] Booking.com, Agoda 추가
- [ ] 기능 추가
  - [ ] 실시간 가격 비교
  - [ ] 가격 알림
  - [ ] 사용자 히스토리
- [ ] ML 모델 개발
  - [ ] KoBERT 파인튜닝
  - [ ] 협업 필터링
- [ ] 제휴 및 수익화
  - [ ] 야놀자/여기어때 제휴
  - [ ] Affiliate 링크 적용

**목표 지표:**
- 호텔 500개
- MAU 5,000명
- 월 수익 ₩900,000

### 🚀 Phase 3: 고도화 (2026년 6월+)

- [ ] 고급 기능
  - [ ] 이미지 분석
  - [ ] Q&A 챗봇
  - [ ] 개인화 대시보드
- [ ] 비즈니스 확장
  - [ ] B2B 서비스
  - [ ] 프리미엄 구독
  - [ ] API 판매
- [ ] 지역 확장
  - [ ] 전국 주요 도시
  - [ ] 해외 진출

**목표 지표:**
- MAU 50,000명
- 월 수익 ₩20,000,000
- Series A 투자 유치

---

## 🧪 테스트

### Backend Tests

```bash
cd backend

# 전체 테스트 실행
pytest

# 커버리지 포함
pytest --cov=app --cov-report=html

# 특정 테스트만
pytest tests/test_hotel_service.py -v
```

### Frontend Tests

```bash
cd frontend

# 단위 테스트
npm run test

# E2E 테스트
npm run test:e2e

# 커버리지
npm run test:coverage
```

---

## 🤝 기여하기

기여를 환영합니다! 다음 절차를 따라주세요:

### 개발 워크플로우

1. **Fork** 이 저장소
2. **Branch** 생성 (`git checkout -b feature/AmazingFeature`)
3. **Commit** 변경사항 (`git commit -m 'feat: Add some AmazingFeature'`)
4. **Push** to Branch (`git push origin feature/AmazingFeature`)
5. **Pull Request** 생성

### 커밋 메시지 컨벤션

```
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷팅, 세미콜론 누락 등
refactor: 코드 리팩토링
test: 테스트 코드 추가
chore: 빌드 업무 수정, 패키지 매니저 설정 등
```

### 코드 스타일

**Python (Backend):**
```bash
# Black 포맷터
black app/

# Flake8 린터
flake8 app/

# isort (import 정렬)
isort app/
```

**TypeScript (Frontend):**
```bash
# Prettier 포맷터
npm run format

# ESLint 린터
npm run lint

# 자동 수정
npm run lint:fix
```

---

## 📊 성능 지표

### 목표 성능

- API 응답 시간: P95 < 500ms
- LLM 분류 정확도: 85% 이상
- 시스템 가용성: 99.5%
- 크롤링 성공률: 95% 이상

### 모니터링

- **Sentry**: 에러 추적 및 알림
- **Google Analytics**: 사용자 행동 분석
- **New Relic** (선택): APM 및 성능 모니터링
- **Grafana** (선택): 시스템 메트릭 대시보드

---

## 🔒 보안

### 보안 고려사항

- ✅ HTTPS 필수
- ✅ API Key 환경변수 관리
- ✅ SQL Injection 방지 (NoSQL 사용)
- ✅ XSS 방지
- ✅ CSRF 토큰
- ✅ Rate Limiting
- ✅ Input Validation (Pydantic)

### 취약점 보고

보안 취약점을 발견하셨다면 공개 이슈 대신 이메일로 연락주세요:
security@hotelmatch.com

---

## 📝 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다. 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.

---

## 👥 팀

- **Project Lead**: 남욱 ([@namwook](https://github.com/namwook))
- **Backend Developer**: TBD
- **Frontend Developer**: TBD
- **UI/UX Designer**: TBD

---

## 📞 연락처

- **Website**: https://www.hotelmatch.com (예정)
- **Email**: contact@hotelmatch.com
- **GitHub**: https://github.com/your-org/hotel-recommendation

---

## 🙏 감사의 글

이 프로젝트는 다음 오픈소스 프로젝트들을 사용합니다:

- [FastAPI](https://fastapi.tiangolo.com/) - 현대적인 Python 웹 프레임워크
- [React](https://reactjs.org/) - UI 라이브러리
- [MongoDB](https://www.mongodb.com/) - NoSQL 데이터베이스
- [OpenAI](https://openai.com/) - GPT-4o-mini API
- [Playwright](https://playwright.dev/) - 브라우저 자동화
- [Tailwind CSS](https://tailwindcss.com/) - 유틸리티 CSS 프레임워크

---

## 📖 추가 문서

- [아키텍처 설계](docs/architecture/README.md)
- [API 명세서](docs/api/README.md)
- [UI/UX 가이드](docs/design/README.md)
- [배포 가이드](docs/deployment/README.md)
- [개발 시작하기](docs/getting-started/README.md)

---

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=your-org/hotel-recommendation&type=Date)](https://star-history.com/#your-org/hotel-recommendation&Date)

---

**Made with ❤️ by HotelMatch Team**

*Last Updated: 2025-11-16*
