FROM maven:3-jdk-8 as builder

WORKDIR /src
COPY . /src

# Use the find command to locate the pom.xml file
RUN find /src -name "pom.xml"

# Build the project using Maven
RUN mvn -B -f $(find /src -name "pom.xml") clean package -DskipTests

FROM openjdk:8-jdk-alpine

ENV JAVA_OPTIONS "-Djava.net.preferIPv4Stack=true"
WORKDIR /app

# Use a wildcard to copy any JAR file from /src/target/ to /app/app.jar
COPY --from=builder /src/target/demo-*.jar /app/app.jar

CMD ["java", "-jar", "/app/app.jar"]
EXPOSE 8080
