# 1. 사용할 기본 이미지 (Java 17)
FROM eclipse-temurin:17-jdk-alpine

# 2. 작업 디렉토리 설정
WORKDIR /app

# 3. Gradle 캐시를 위한 디렉토리 복사 및 빌드 도구 다운로드
COPY gradlew /app/gradlew
COPY gradle /app/gradle
RUN chmod +x ./gradlew

# 4. 로컬 소스가 변경될 때마다 빌드
CMD ["./gradlew", "bootRun"]
