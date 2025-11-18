# Git 저장소 초기화 가이드

이 문서는 HotelMatch 프로젝트를 Git 저장소로 초기화하고 GitHub에 올리는 방법을 설명합니다.

---

## 1. 로컬 프로젝트 디렉토리 생성

```bash
# 프로젝트 디렉토리 생성
mkdir hotel-recommendation
cd hotel-recommendation

# 기본 디렉토리 구조 생성
mkdir -p backend/app
mkdir -p frontend/src
mkdir -p docs
mkdir -p scripts
```

---

## 2. 필수 파일 복사

다음 파일들을 프로젝트 루트에 복사하세요:

```
hotel-recommendation/
├── README.md              ✅ 복사
├── .gitignore            ✅ 복사
├── LICENSE               ✅ 복사
├── docker-compose.yml    ✅ 복사
└── .env.example          ✅ 복사
```

---

## 3. Git 초기화

### 3.1 로컬 저장소 초기화

```bash
# Git 초기화
git init

# 현재 상태 확인
git status
```

### 3.2 첫 커밋

```bash
# 모든 파일 스테이징
git add .

# 첫 커밋
git commit -m "chore: Initial project setup

- Add README.md with project overview
- Add .gitignore for Python, Node.js, and Docker
- Add MIT LICENSE
- Add docker-compose.yml for development
- Add .env.example template"
```

---

## 4. GitHub 저장소 생성

### 4.1 GitHub에서 새 저장소 생성

1. https://github.com 접속
2. 우측 상단 **[+]** → **New repository** 클릭
3. 저장소 설정:
   ```
   Repository name: hotel-recommendation
   Description: 🏨 AI-powered hotel recommendation service based on travel purpose
   Public or Private: 선택
   
   ⚠️ 중요: 다음 항목들은 체크하지 마세요
   [ ] Add a README file
   [ ] Add .gitignore
   [ ] Choose a license
   ```
4. **Create repository** 클릭

### 4.2 로컬 저장소와 연결

GitHub에 표시되는 명령어를 실행:

```bash
# 원격 저장소 추가
git remote add origin https://github.com/your-username/hotel-recommendation.git

# 브랜치 이름 확인 (main 또는 master)
git branch

# 브랜치 이름이 master면 main으로 변경 (선택)
git branch -M main

# GitHub에 푸시
git push -u origin main
```

---

## 5. 브랜치 전략 설정

### 5.1 기본 브랜치 생성

```bash
# develop 브랜치 생성
git checkout -b develop
git push -u origin develop

# main 브랜치로 돌아가기
git checkout main
```

### 5.2 브랜치 보호 규칙 설정 (GitHub)

1. GitHub 저장소 페이지
2. **Settings** → **Branches**
3. **Add branch protection rule**
4. Branch name pattern: `main`
5. 설정:
   - ✅ Require a pull request before merging
   - ✅ Require approvals (1)
   - ✅ Require status checks to pass before merging
6. **Create**

---

## 6. GitHub Actions 설정 (CI/CD)

### 6.1 워크플로우 디렉토리 생성

```bash
mkdir -p .github/workflows
```

### 6.2 기본 CI 워크플로우 생성

`.github/workflows/ci.yml` 파일 생성:

```yaml
name: CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: |
        echo "Dependencies will be installed here"
    
    - name: Run tests
      run: |
        echo "Tests will run here"
```

커밋 및 푸시:

```bash
git add .github/
git commit -m "ci: Add GitHub Actions CI workflow"
git push
```

---

## 7. 협업자 초대 (팀 프로젝트인 경우)

1. GitHub 저장소 페이지
2. **Settings** → **Collaborators**
3. **Add people**
4. 협업자 GitHub 아이디 입력
5. 권한 선택:
   - **Admin**: 모든 권한
   - **Write**: 코드 푸시 가능
   - **Read**: 읽기만 가능

---

## 8. 이슈 템플릿 설정

### 8.1 이슈 템플릿 생성

```bash
mkdir -p .github/ISSUE_TEMPLATE
```

`.github/ISSUE_TEMPLATE/bug_report.md`:

```markdown
---
name: Bug Report
about: 버그 신고
title: '[BUG] '
labels: bug
assignees: ''
---

## 버그 설명
버그에 대한 명확하고 간결한 설명

## 재현 방법
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

## 예상 동작
정상적으로 어떻게 동작해야 하는지

## 스크린샷
가능하면 스크린샷 첨부

## 환경
 - OS: [e.g. macOS, Windows]
 - Browser: [e.g. chrome, safari]
 - Version: [e.g. 22]
```

`.github/ISSUE_TEMPLATE/feature_request.md`:

```markdown
---
name: Feature Request
about: 새 기능 제안
title: '[FEATURE] '
labels: enhancement
assignees: ''
---

## 기능 설명
제안하는 기능에 대한 명확한 설명

## 해결하려는 문제
이 기능이 어떤 문제를 해결하는지

## 대안
고려한 다른 대안이 있다면 설명
```

커밋 및 푸시:

```bash
git add .github/ISSUE_TEMPLATE/
git commit -m "docs: Add issue templates"
git push
```

---

## 9. Pull Request 템플릿

`.github/pull_request_template.md` 파일 생성:

```markdown
## 변경 사항
이 PR에서 변경한 내용을 설명하세요.

## 관련 이슈
Closes #(issue number)

## 변경 유형
- [ ] Bug fix (버그 수정)
- [ ] New feature (새 기능)
- [ ] Breaking change (기존 기능 변경)
- [ ] Documentation update (문서 업데이트)

## 체크리스트
- [ ] 코드가 프로젝트 스타일 가이드를 따름
- [ ] 자체 리뷰 완료
- [ ] 코드에 주석 추가 (복잡한 부분)
- [ ] 문서 업데이트
- [ ] 테스트 추가
- [ ] 모든 테스트 통과

## 스크린샷 (있다면)
변경 사항의 스크린샷
```

커밋 및 푸시:

```bash
git add .github/pull_request_template.md
git commit -m "docs: Add PR template"
git push
```

---

## 10. README 배지 추가

README.md 상단에 유용한 배지를 추가할 수 있습니다:

```markdown
[![CI](https://github.com/your-username/hotel-recommendation/workflows/CI/badge.svg)](https://github.com/your-username/hotel-recommendation/actions)
[![codecov](https://codecov.io/gh/your-username/hotel-recommendation/branch/main/graph/badge.svg)](https://codecov.io/gh/your-username/hotel-recommendation)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
```

---

## 11. 개발 시작

### 11.1 환경 변수 설정

```bash
# .env 파일 생성
cp .env.example .env

# 편집기로 .env 열기
nano .env  # 또는 code .env
```

필수 설정:
- `OPENAI_API_KEY`: OpenAI API 키
- `MONGODB_URI`: MongoDB 연결 문자열
- `SECRET_KEY`: 보안 키 (랜덤 생성)

### 11.2 Docker로 개발 환경 시작

```bash
# 모든 서비스 시작
docker-compose up -d

# 로그 확인
docker-compose logs -f

# 특정 서비스만 시작
docker-compose up -d mongodb redis

# 중지
docker-compose down
```

### 11.3 첫 기능 개발

```bash
# feature 브랜치 생성
git checkout develop
git checkout -b feature/setup-backend-structure

# 개발 진행...

# 커밋
git add .
git commit -m "feat: Setup basic FastAPI structure"

# 푸시
git push -u origin feature/setup-backend-structure
```

### 11.4 Pull Request 생성

1. GitHub 저장소 페이지 접속
2. **Pull requests** → **New pull request**
3. base: `develop` ← compare: `feature/setup-backend-structure`
4. 제목과 설명 작성
5. **Create pull request**

---

## 12. 유용한 Git 명령어

### 12.1 일상적인 작업

```bash
# 현재 상태 확인
git status

# 변경사항 확인
git diff

# 최근 커밋 로그
git log --oneline -10

# 브랜치 목록
git branch -a

# 원격 저장소 동기화
git fetch origin
git pull origin develop
```

### 12.2 브랜치 관리

```bash
# 새 브랜치 생성 및 이동
git checkout -b feature/new-feature

# 브랜치 전환
git checkout develop

# 브랜치 삭제
git branch -d feature/old-feature

# 원격 브랜치 삭제
git push origin --delete feature/old-feature
```

### 12.3 문제 해결

```bash
# 마지막 커밋 수정
git commit --amend

# 커밋 취소 (변경사항 유지)
git reset --soft HEAD~1

# 커밋 취소 (변경사항 제거)
git reset --hard HEAD~1

# 특정 파일만 스테이징 취소
git restore --staged filename

# 모든 변경사항 되돌리기
git restore .

# 원격 저장소 상태로 강제 동기화 (주의!)
git fetch origin
git reset --hard origin/main
```

---

## 13. 체크리스트

프로젝트 시작 전 확인:

- [ ] Git 설치 확인 (`git --version`)
- [ ] GitHub 계정 생성
- [ ] SSH 키 등록 (권장)
- [ ] 로컬 저장소 초기화
- [ ] GitHub 원격 저장소 생성
- [ ] 로컬과 원격 연결
- [ ] 첫 커밋 및 푸시
- [ ] README.md 작성
- [ ] .gitignore 설정
- [ ] LICENSE 추가
- [ ] 브랜치 전략 설정
- [ ] 협업자 초대 (필요 시)
- [ ] 이슈 템플릿 생성
- [ ] PR 템플릿 생성
- [ ] CI/CD 설정 시작

---

## 14. 추가 리소스

- [Git 공식 문서](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com/)
- [Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow](https://guides.github.com/introduction/flow/)

---

## 15. 문제 해결

### Q1: git push 시 권한 오류

**증상:**
```
remote: Permission to user/repo.git denied to user.
fatal: unable to access 'https://github.com/user/repo.git/': The requested URL returned error: 403
```

**해결:**
```bash
# Personal Access Token 사용
git remote set-url origin https://<token>@github.com/username/repo.git

# 또는 SSH 사용 (권장)
git remote set-url origin git@github.com:username/repo.git
```

### Q2: .env 파일이 커밋됨

**해결:**
```bash
# Git 캐시에서 제거
git rm --cached .env

# .gitignore에 추가 확인
echo ".env" >> .gitignore

# 커밋
git add .gitignore
git commit -m "fix: Remove .env from git tracking"
git push
```

### Q3: 브랜치 충돌

**해결:**
```bash
# 최신 상태 가져오기
git fetch origin

# develop 브랜치 업데이트
git checkout develop
git pull origin develop

# feature 브랜치에서 rebase
git checkout feature/your-feature
git rebase develop

# 충돌 해결 후
git add .
git rebase --continue
git push -f origin feature/your-feature
```

---

**작성일**: 2025-11-16
**마지막 업데이트**: 2025-11-16
