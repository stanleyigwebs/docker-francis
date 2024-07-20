#https://github.com/laradock/laradock/blob/master/redis/Dockerfile
FROM redis:7

ARG REDIS_PASSWORD

## For security settings uncomment, make the dir, copy conf, and also start with the conf, to use it
#RUN mkdir -p /usr/local/etc/redis
#COPY redis.conf /usr/local/etc/redis/redis.conf

VOLUME /data

EXPOSE 6379

#CMD ["redis-server", "/usr/local/etc/redis/redis.conf"]
CMD ["redis-server", "--requiepass", "${REDIS_PASSWORD}"]
