# Этап 1: Стадия сборки
FROM ubuntu:latest AS build

RUN apt-get update && \
apt-get install -y openjdk-17-jdk maven && \
apt-get clean;

WORKDIR /app

COPY . .

RUN mvn clean package

FROM openjdk:17-jdk-slim

EXPOSE 27004

WORKDIR /app

COPY —from=build /app/target/*.jar app.jar

# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]