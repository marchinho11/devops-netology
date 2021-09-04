FROM ubuntu:latest

RUN apt update && \
    apt install -y wget openjdk-8-jdk

RUN wget https://get.jenkins.io/war-stable/2.303.1/jenkins.war

ENTRYPOINT ["java", "-jar", "jenkins.war"]
