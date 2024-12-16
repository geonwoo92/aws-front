# 빌드 단계
FROM node:18 AS builder

WORKDIR /app

# 의존성 설치
COPY package.json package-lock.json ./
RUN npm install

# 프로젝트 파일 복사 및 빌드
COPY . ./
RUN npm run build  # next build 명령어 실행

# 실제 실행 단계
FROM node:18

WORKDIR /app

# 빌드된 .next 파일과 node_modules만 복사
COPY --from=builder /app/.next ./.next  # 빌드된 .next 폴더
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules  # node_modules 복사

# 포트 설정
EXPOSE 3000

# 실행 명령
CMD ["npm", "start"]
