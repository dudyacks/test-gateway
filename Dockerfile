FROM openjdk:17-jdk-slim AS build
COPY . /app
WORKDIR /app
RUN ./gradlew clean build

FROM openjdk:17-oracle
COPY --from=build /app/build/libs/demo-gateway-0.0.1-SNAPSHOT.jar /app/app.jar
CMD ["java", "-jar", "/app/app.jar"]
EXPOSE 8085
