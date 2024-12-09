# Stage 1: Build
FROM maven:3.9.0-eclipse-temurin-17 as builder

# Set working directory inside the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml ./
COPY src ./src

# Build the application using Maven
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jdk-alpine

# Set working directory inside the container
WORKDIR /app

# Copy the application JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application's port (e.g., 8080)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
