# First stage, "build-stage", based on Maven, to build the service
FROM maven:3.9.5-eclipse-temurin-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:go-offline
COPY src ./src
RUN mvn -e -B package

# Second stage, based on openJDK, to have only the compiled service, ready for production with payara micro
FROM eclipse-temurin:11-jdk
COPY --from=build /app/target/service-microbundle.jar /
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/service-microbundle.jar", "--port", "8080"]
