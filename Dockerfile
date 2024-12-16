# 1단계: 빌드용 Node.js 이미지
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

# 종속성 설치
RUN npm install --legacy-peer-deps

# 애플리케이션 소스 복사
COPY . .

# 빌드 실행
RUN npm run build

# 2단계: 실행용 이미지
FROM node:18-slim

WORKDIR /app

# 빌드된 결과물 복사
COPY --from=builder /app ./

# Next.js 프로덕션 서버 실행
EXPOSE 3000
CMD ["npm", "run", "start"]
