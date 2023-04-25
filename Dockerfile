FROM openjdk:17-alpine AS build
COPY . /app
WORKDIR /app
RUN ./gradlew clean build
COPY build/libs/demo-gateway-0.0.1-SNAPSHOT.jar ./application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:17-alpine
WORKDIR application
COPY --from=builder app/dependencies/ ./
COPY --from=builder app/spring-boot-loader/ ./
COPY --from=builder app/snapshot-dependencies/ ./
COPY --from=builder app/application/ ./
EXPOSE 8085
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
