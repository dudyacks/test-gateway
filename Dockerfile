FROM openjdk:17-jdk-alpine AS builder
COPY . /app
WORKDIR /app
RUN ./gradlew clean build

FROM openjdk:17-jdk-alpine

COPY --from=builder /app/build/libs/*.jar application.jar
COPY /source/build/libs/demo-gateway-0.0.1-SNAPSHOT.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract

WORKDIR application
COPY --from=builder source/dependencies/ ./
COPY --from=builder source/spring-boot-loader/ ./
COPY --from=builder source/snapshot-dependencies/ ./
COPY --from=builder source/application/ ./
EXPOSE 8085
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
