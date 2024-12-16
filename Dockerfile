# Stage 1: 빌드 환경
FROM node:18 AS builder

# 앱 디렉토리 설정
WORKDIR /app

# package.json과 package-lock.json만 먼저 복사하여 의존성 캐시 최적화
COPY package.json package-lock.json ./

# 의존성 설치 (next-router 삭제와 next 설치)
RUN npm uninstall next-router && \
    npm install next && \
    npm install --legacy-peer-deps

# 앱 파일 복사
COPY . .

# Next.js 빌드
RUN npm run build

# Stage 2: 실행 환경
FROM node:18-slim

# 실행 환경에서 필요한 파일만 복사
WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# 3000 포트를 외부에 개방
EXPOSE 3000

# Next.js 앱 실행
CMD ["npm", "run", "start"]
