# 1단계: Node.js 기반 빌드 환경
FROM node:18 AS builder

WORKDIR /app

# package.json과 package-lock.json을 먼저 복사
COPY package*.json ./

# 종속성 설치 (가능한 한 빨리, 캐시를 활용)
RUN npm install --legacy-peer-deps --prefer-offline

# 애플리케이션 소스 복사
COPY . .

# Next.js 빌드 실행
RUN npm run build

# 2단계: 실행 환경
FROM node:18-slim

WORKDIR /app

# 빌드된 애플리케이션 파일 복사
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package*.json ./  # package.json, package-lock.json 복사
COPY --from=builder /app/node_modules ./node_modules  # node_modules 복사
COPY --from=builder /app/public ./public  # public 폴더 복사

# Next.js 프로덕션 서버 실행
EXPOSE 3000
CMD ["npm", "run", "start"]
