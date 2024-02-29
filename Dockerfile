FROM maven:3-jdk-8 as builder
WORKDIR /src
COPY . /src
RUN mvn -B -f pom.xml clean package -DskipTests

FROM openjdk:8-jdk-alpine
ENV JAVA_OPTIONS "-Djava.net.preferIPv4Stack=true"
WORKDIR /app
COPY --from=builder /src/target/demo-1.0.2.jar /app/app.jar
CMD ["java", "-jar", "/app/app.jar"]
EXPOSE 8080
