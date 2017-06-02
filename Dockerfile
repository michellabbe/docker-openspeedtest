FROM alpine:3.6
#FROM nginx:stable-alpine

MAINTAINER Michel Labbe

COPY /files/www/* /var/www/localhost/htdocs/
COPY /files/openspeedtest.conf /etc/nginx/conf.d

RUN apk add --no-cache nginx \
    && rm -rf /etc/nginx/conf.d/default.conf \
    #&& mv /tmp/openspeedtest.conf /etc/nginx/conf.d/ \

         # not sure why but during build wget downloads a 42 MB downloading file instead of a 155 MB file \
         # so Download test result suck at high speed (e.g. shows 40 Mbps instead of 500+ Mbps)           \
         # As a workaround, for now I downloaded the 155 MB file manually and COPY it instead             \
    #&& wget http://openspeedtest.com/downloading -O /tmp/downloading \
    #&& wget http://openspeedtest.com/load/upload -O /tmp/upload \
    && wget http://get.openspeedtest.com/images/favicon.png -O /tmp/favicon.png \
    
         # Make sure default website dir is empty before moving files \
    #&& rm -rf /var/www/localhost/htdocs/* \
    && mv /tmp/downloading /var/www/localhost/htdocs/ \
    && mv /tmp/upload /var/www/localhost/htdocs/ \
    && mv /tmp/favicon.png /var/www/localhost/htdocs/ \
    && mv /tmp/index.htm /var/www/localhost/htdocs \
    && chown -R nginx /var/www/localhost/htdocs \
    && chmod 755 /var/www/localhost/htdocs/downloading \
    && chmod 755 /var/www/localhost/htdocs/upload \

         # Fix errors on startup \
    && touch /var/log/nginx/error.log \
    && chown -R nginx /var/log/nginx/error.log \
    && touch /var/log/nginx/access.log \
    && chown -R nginx /var/log/nginx/access.log \
    && mkdir -p /run/nginx \
    && chown -R nginx /run/nginx
    
USER nginx

# Listen to required port(s)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]