FROM alpine:3.6
ARG ARCH
ARG MPDUID
ARG AUDIOGID
RUN apk update &&  apk add bash mpd mpc shadow \
tzdata \
sudo && \
usermod -u $MPDUID mpd && \
groupmod -g $AUDIOGID audio && \
apk del shadow && \
rm -rf /var/cache/apk/* 
ENV TZ Europe/Paris
COPY mpd.conf /etc/conf.d/
EXPOSE 6600 8000
CMD mpd --no-daemon /etc/conf.d/mpd.conf
