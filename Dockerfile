FROM alpine/git as gitclone

WORKDIR /app
RUN git clone https://github.com/mrsrikanthcool/maven-tomcat-dockermultistage.git

FROM maven:3.8.2-openjdk-11 as build
WORKDIR /app
COPY --from=gitclone /app/maven-tomcat-dockermultistage ./
RUN mvn package

FROM tomcat:9.0
ARG artifact_id
ARG version
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080
