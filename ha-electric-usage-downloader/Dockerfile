ARG BUILD_FROM
FROM $BUILD_FROM


COPY run.sh /

# version of tedpearson/electric-usage-downloader
ARG BUILD_ARCH VERSION=v2.2.0

#RUN mkdir /app
WORKDIR /app
ADD https://github.com/tedpearson/electric-usage-downloader/releases/download/$VERSION/electric-usage-downloader-linux-$BUILD_ARCH electric-usage-downloader


# gcompat #apk add musl musl-dev gcompat && \  
RUN \
    chmod a+x electric-usage-downloader && \
    chmod a+x /run.sh

CMD [ "/run.sh" ]