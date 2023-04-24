FROM openjdk:17-jdk-alpine AS builder
COPY . /source
WORKDIR source
RUN ./gradlew clean build
RUN echo $(ls -1)
COPY build/libs/*.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:17-jdk-alpine
WORKDIR application
COPY --from=builder source/dependencies/ ./
COPY --from=builder source/spring-boot-loader/ ./
COPY --from=builder source/snapshot-dependencies/ ./
COPY --from=builder source/application/ ./
EXPOSE 8085
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
