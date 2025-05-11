# Use Maven to build
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

# Use OpenJDK to run
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/*.war app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]

