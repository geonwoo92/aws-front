# Stage 1: 빌드 환경
FROM node:18 AS builder

# 앱 디렉토리 설정
WORKDIR /app

# package.json과 package-lock.json 복사
COPY package.json package-lock.json ./

# next-router 삭제
RUN npm uninstall next-router

# next 설치
RUN npm install next

# 의존성 설치
RUN npm install

# 앱 파일 복사
COPY . .

# Next.js 빌드
RUN npm run build

# Stage 2: 실행 환경
FROM node:18-slim

WORKDIR /app

# 빌드된 파일 및 의존성만 복사
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# 앱 실행
CMD ["npm", "start"]
