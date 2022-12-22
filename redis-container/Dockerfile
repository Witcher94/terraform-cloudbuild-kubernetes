FROM alpine:latest
RUN apk update && \
    apk add --no-cache redis && \
    apk add --no-cache  'su-exec>=0.2'
COPY entrypoint.sh /usr/local/bin/
WORKDIR /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 6379
CMD ["redis-server"]