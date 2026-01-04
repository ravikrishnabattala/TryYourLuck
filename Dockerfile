# ---------- Build stage ----------
FROM eclipse-temurin:17-jdk AS builder

LABEL authors="ravik"

WORKDIR /app

# Install Maven
RUN apt-get update && apt-get install -y maven

# Copy project files
COPY . .

# Build the JAR
RUN mvn clean package -DskipTests

# ---------- Runtime stage ----------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# 2. Copy jar file to container
COPY --from=builder /app/target/Casino-1.0-SNAPSHOT.jar app.jar

# 3. Run the jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
