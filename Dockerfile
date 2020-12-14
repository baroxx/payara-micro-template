# First stage, "build-stage", based on Maven, to build the service
FROM maven:3.6.3-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:go-offline
COPY src ./src
RUN mvn -e -B package

# Second stage, based on openJDK, to have only the compiled service, ready for production with payara micro
FROM adoptopenjdk/openjdk11:x86_64-alpine-jre-11.0.8_10
COPY --from=build /app/target/service-microbundle.jar /
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/service-microbundle.jar", "--port", "8080"]