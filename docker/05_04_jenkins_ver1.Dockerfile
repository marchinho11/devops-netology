FROM amazoncorretto:8

RUN curl -LO https://get.jenkins.io/war-stable/2.303.1/jenkins.war

ENTRYPOINT ["java", "-jar", "jenkins.war"]
