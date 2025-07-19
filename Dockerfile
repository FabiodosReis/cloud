FROM openjdk:21-slim

WORKDIR /app

ENV AWS_REGION=us-east-1

COPY target/cloud-*.jar /app/cloud.jar

EXPOSE 8080

CMD ["java", "-jar", "cloud.jar"]

