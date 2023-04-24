FROM openjdk:17-jdk-alpine AS builder
COPY . /app
WORKDIR /app
RUN ./gradlew clean build

FROM openjdk:17-jdk-alpine

COPY --from=builder /app/build/libs/*.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract

WORKDIR application
COPY --from=builder app/dependencies/ ./
COPY --from=builder app/spring-boot-loader/ ./
COPY --from=builder app/snapshot-dependencies/ ./
COPY --from=builder app/application/ ./
EXPOSE 8085
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
