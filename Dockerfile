FROM alpine/curl AS downloader

# Download the application.
ARG VERSION=0.4.3
RUN curl -sfL https://github.com/noxianwill/MusicBot/releases/download/v${VERSION}-fixed/JMusicBot-${VERSION}-fixed.jar > JMusicBot.jar

FROM openjdk:26-ea

WORKDIR /opt/app
ARG VERSION
ENV VERSION=${VERSION}
COPY --from=downloader /JMusicBot.jar /opt/app/JMusicBot.jar

WORKDIR /opt/app/config
CMD ["java", "-Dnogui=true", "-jar", "/opt/app/JMusicBot.jar"]
