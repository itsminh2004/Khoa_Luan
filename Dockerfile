FROM eclipse-temurin:8-jdk-jammy

WORKDIR /app

COPY . .

RUN chmod +x mvnw && ./mvnw clean package -DskipTests

CMD ["sh", "-c", "java -jar target/*.jar"]