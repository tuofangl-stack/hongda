# ============ Stage 1: 构建前端 ============
FROM node:16-alpine AS frontend-build
WORKDIR /app/portal-ui
COPY portal-ui/package.json portal-ui/package-lock.json ./
RUN npm ci
COPY portal-ui/ ./
RUN npm run build

# ============ Stage 2: 构建后端 ============
FROM maven:3.8-openjdk-8 AS backend-build
WORKDIR /build/portal-server
COPY portal-server/pom.xml ./
RUN mvn dependency:go-offline -B
COPY portal-server/src ./src
COPY --from=frontend-build /app/portal-ui/dist/ ./src/main/resources/static/
RUN mvn package -DskipTests -B

# ============ Stage 3: 运行 ============
FROM eclipse-temurin:8-jre
WORKDIR /app
COPY --from=backend-build /build/portal-server/target/portal-server-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
