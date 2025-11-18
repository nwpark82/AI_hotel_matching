#!/bin/bash

# HotelMatch 프로젝트 빠른 시작 스크립트
# 이 스크립트는 프로젝트 초기 설정을 자동화합니다.

set -e  # 에러 발생 시 스크립트 중단

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 함수: 색상 출력
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 함수: 명령어 존재 여부 확인
check_command() {
    if ! command -v $1 &> /dev/null; then
        return 1
    fi
    return 0
}

# 배너 출력
echo ""
echo "╔═══════════════════════════════════════════════╗"
echo "║                                               ║"
echo "║     🏨 HotelMatch - Quick Start Script       ║"
echo "║                                               ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""

# 1. Prerequisites 확인
print_info "Checking prerequisites..."

# Git 확인
if check_command git; then
    GIT_VERSION=$(git --version | awk '{print $3}')
    print_success "Git installed (version: $GIT_VERSION)"
else
    print_error "Git is not installed. Please install Git first."
    exit 1
fi

# Python 확인
if check_command python3; then
    PYTHON_VERSION=$(python3 --version | awk '{print $2}')
    print_success "Python installed (version: $PYTHON_VERSION)"
else
    print_error "Python 3 is not installed. Please install Python 3.11+."
    exit 1
fi

# Node.js 확인
if check_command node; then
    NODE_VERSION=$(node --version | sed 's/v//')
    print_success "Node.js installed (version: $NODE_VERSION)"
else
    print_error "Node.js is not installed. Please install Node.js 18+."
    exit 1
fi

# Docker 확인 (선택적)
if check_command docker; then
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
    print_success "Docker installed (version: $DOCKER_VERSION)"
    DOCKER_AVAILABLE=true
else
    print_warning "Docker is not installed. You can install it later for easier setup."
    DOCKER_AVAILABLE=false
fi

echo ""

# 2. 프로젝트 디렉토리 구조 생성
print_info "Creating project directory structure..."

mkdir -p backend/app/{api,core,models,services,crawlers,database,schemas,utils,tasks,tests}
mkdir -p backend/app/api/v1
mkdir -p backend/logs
mkdir -p frontend/src/{components,pages,hooks,services,stores,types,utils,assets}
mkdir -p frontend/src/components/{common,hotel,search,layout}
mkdir -p frontend/public
mkdir -p docs/{architecture,api,design,deployment}
mkdir -p scripts

print_success "Directory structure created"

# 3. Git 초기화
print_info "Initializing Git repository..."

if [ -d ".git" ]; then
    print_warning "Git repository already initialized"
else
    git init
    print_success "Git repository initialized"
fi

# 4. .env 파일 생성
print_info "Setting up environment files..."

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        print_success ".env file created from template"
        print_warning "⚠️  Please edit .env file with your actual credentials"
    else
        print_error ".env.example not found"
    fi
else
    print_warning ".env file already exists"
fi

# Backend .env
if [ ! -f "backend/.env" ]; then
    cat > backend/.env << EOF
MONGODB_URI=mongodb://admin:password@localhost:27017/hotel_recommendation?authSource=admin
REDIS_URL=redis://localhost:6379
OPENAI_API_KEY=your-openai-api-key-here
APP_ENV=development
DEBUG=true
SECRET_KEY=$(python3 -c 'import secrets; print(secrets.token_urlsafe(32))')
CORS_ORIGINS=http://localhost:5173
EOF
    print_success "backend/.env created"
else
    print_warning "backend/.env already exists"
fi

# Frontend .env
if [ ! -f "frontend/.env" ]; then
    cat > frontend/.env << EOF
VITE_API_BASE_URL=http://localhost:8000/api/v1
VITE_GA_TRACKING_ID=
EOF
    print_success "frontend/.env created"
else
    print_warning "frontend/.env already exists"
fi

echo ""

# 5. Backend 기본 파일 생성
print_info "Creating backend basic files..."

# requirements.txt
if [ ! -f "backend/requirements.txt" ]; then
    cat > backend/requirements.txt << EOF
# FastAPI and server
fastapi==0.104.1
uvicorn[standard]==0.24.0
pydantic==2.5.0
pydantic-settings==2.1.0

# Database
motor==3.3.2
pymongo==4.6.0
redis==5.0.1

# AI/ML
openai==1.3.7

# Crawling
playwright==1.40.0

# Auth & Security
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.6

# Utilities
python-dotenv==1.0.0
httpx==0.25.2
EOF
    print_success "requirements.txt created"
fi

# main.py
if [ ! -f "backend/app/main.py" ]; then
    cat > backend/app/main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings

app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION,
    docs_url="/docs",
    redoc_url="/redoc"
)

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {
        "message": "Welcome to HotelMatch API",
        "version": settings.APP_VERSION,
        "docs": "/docs"
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )
EOF
    print_success "backend/app/main.py created"
fi

# config.py
if [ ! -f "backend/app/core/config.py" ]; then
    mkdir -p backend/app/core
    cat > backend/app/core/config.py << 'EOF'
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    APP_NAME: str = "HotelMatch"
    APP_VERSION: str = "1.0.0"
    APP_ENV: str = "development"
    DEBUG: bool = True
    
    MONGODB_URI: str
    REDIS_URL: str
    OPENAI_API_KEY: str
    SECRET_KEY: str
    
    CORS_ORIGINS: list[str] = ["http://localhost:5173"]
    
    class Config:
        env_file = ".env"

settings = Settings()
EOF
    print_success "backend/app/core/config.py created"
fi

# __init__.py 파일들
touch backend/app/__init__.py
touch backend/app/api/__init__.py
touch backend/app/api/v1/__init__.py
touch backend/app/core/__init__.py
touch backend/app/models/__init__.py
touch backend/app/services/__init__.py

echo ""

# 6. Frontend 기본 파일 생성
print_info "Creating frontend basic files..."

# package.json
if [ ! -f "frontend/package.json" ]; then
    cat > frontend/package.json << 'EOF'
{
  "name": "hotelmatch-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint . --ext ts,tsx",
    "format": "prettier --write \"src/**/*.{ts,tsx,css}\""
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.0",
    "zustand": "^4.4.7",
    "axios": "^1.6.2",
    "@tanstack/react-query": "^5.12.2",
    "recharts": "^2.10.3"
  },
  "devDependencies": {
    "@types/react": "^18.2.43",
    "@types/react-dom": "^18.2.17",
    "@typescript-eslint/eslint-plugin": "^6.14.0",
    "@typescript-eslint/parser": "^6.14.0",
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.16",
    "eslint": "^8.55.0",
    "eslint-plugin-react-hooks": "^4.6.0",
    "postcss": "^8.4.32",
    "prettier": "^3.1.1",
    "tailwindcss": "^3.3.6",
    "typescript": "^5.3.3",
    "vite": "^5.0.8"
  }
}
EOF
    print_success "frontend/package.json created"
fi

# vite.config.ts
if [ ! -f "frontend/vite.config.ts" ]; then
    cat > frontend/vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 5173,
    host: true,
  },
})
EOF
    print_success "frontend/vite.config.ts created"
fi

# tailwind.config.js
if [ ! -f "frontend/tailwind.config.js" ]; then
    cat > frontend/tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          800: '#1e40af',
          900: '#1e3a8a',
        },
      },
    },
  },
  plugins: [],
}
EOF
    print_success "frontend/tailwind.config.js created"
fi

echo ""

# 7. Docker 설정 (있는 경우)
if [ "$DOCKER_AVAILABLE" = true ]; then
    print_info "Would you like to start Docker services? (y/n)"
    read -r START_DOCKER
    
    if [ "$START_DOCKER" = "y" ] || [ "$START_DOCKER" = "Y" ]; then
        if [ -f "docker-compose.yml" ]; then
            print_info "Starting Docker services..."
            docker-compose up -d mongodb redis
            print_success "Docker services started (MongoDB, Redis)"
        else
            print_warning "docker-compose.yml not found"
        fi
    fi
fi

echo ""

# 8. Git 첫 커밋
print_info "Would you like to create initial Git commit? (y/n)"
read -r CREATE_COMMIT

if [ "$CREATE_COMMIT" = "y" ] || [ "$CREATE_COMMIT" = "Y" ]; then
    print_info "Creating initial commit..."
    git add .
    git commit -m "chore: Initial project setup

- Add project directory structure
- Add backend basic files
- Add frontend basic files
- Add environment configuration
- Add documentation" || print_warning "Nothing to commit or commit failed"
    print_success "Initial commit created"
fi

echo ""

# 9. 완료 메시지
print_success "✅ Project setup completed!"

echo ""
echo "╔═══════════════════════════════════════════════╗"
echo "║           Next Steps                          ║"
echo "╚═══════════════════════════════════════════════╝"
echo ""
echo "1. Edit environment variables:"
echo "   ${YELLOW}vi .env${NC}"
echo "   ${YELLOW}vi backend/.env${NC}"
echo "   ${YELLOW}vi frontend/.env${NC}"
echo ""
echo "2. Install backend dependencies:"
echo "   ${YELLOW}cd backend${NC}"
echo "   ${YELLOW}python3 -m venv venv${NC}"
echo "   ${YELLOW}source venv/bin/activate${NC}"
echo "   ${YELLOW}pip install -r requirements.txt${NC}"
echo ""
echo "3. Install frontend dependencies:"
echo "   ${YELLOW}cd frontend${NC}"
echo "   ${YELLOW}npm install${NC}"
echo ""
echo "4. Start development servers:"
echo "   ${YELLOW}# Backend (in backend/)${NC}"
echo "   ${YELLOW}uvicorn app.main:app --reload${NC}"
echo ""
echo "   ${YELLOW}# Frontend (in frontend/)${NC}"
echo "   ${YELLOW}npm run dev${NC}"
echo ""
echo "5. Access the application:"
echo "   ${GREEN}Frontend:${NC} http://localhost:5173"
echo "   ${GREEN}Backend API:${NC} http://localhost:8000"
echo "   ${GREEN}API Docs:${NC} http://localhost:8000/docs"
echo ""

if [ "$DOCKER_AVAILABLE" = true ]; then
    echo "6. Docker commands:"
    echo "   ${YELLOW}docker-compose up -d${NC}     # Start all services"
    echo "   ${YELLOW}docker-compose logs -f${NC}   # View logs"
    echo "   ${YELLOW}docker-compose down${NC}      # Stop services"
    echo ""
fi

echo "📚 For more information, see:"
echo "   - README.md"
echo "   - GIT_SETUP_GUIDE.md"
echo "   - docs/"
echo ""

print_success "Happy coding! 🚀"
