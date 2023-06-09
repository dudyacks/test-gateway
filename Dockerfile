FROM openjdk:17-jdk-slim AS build
COPY . /app
WORKDIR /app
RUN ./gradlew clean bootJar

FROM openjdk:17-jdk-slim AS extract
COPY . /app
WORKDIR /app
COPY --from=build /app/build/libs/*.jar application.jar
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:17-jdk-slim AS deploy
WORKDIR application
COPY --from=extract app/dependencies/ ./
COPY --from=extract app/spring-boot-loader/ ./
COPY --from=extract app/snapshot-dependencies/ ./
COPY --from=extract app/application/ ./
EXPOSE 8085
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
#FROM openjdk:17-jdk-slim AS build
#COPY . /app
#WORKDIR /app
#RUN ./gradlew clean build
#COPY build/libs/demo-gateway-0.0.1-SNAPSHOT.jar ./application.jar
#RUN java -Djarmode=layertools -jar application.jar extract
#
#FROM openjdk:17-jdk-slim
#WORKDIR application
#COPY --from=builder app/dependencies/ ./
#COPY --from=builder app/spring-boot-loader/ ./
#COPY --from=builder app/snapshot-dependencies/ ./
#COPY --from=builder app/application/ ./
#EXPOSE 8085
#ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
