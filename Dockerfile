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

# Use a shell command to find the JAR file dynamically and then copy it
RUN cp $(find /src/target -name 'demo-*.jar' -type f -print -quit) /app/app.jar

CMD ["java", "-jar", "/app/app.jar"]
EXPOSE 8080
