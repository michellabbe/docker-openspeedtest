FROM nginx:stable-alpine

MAINTAINER Michel Labbe

COPY /files/www/index.htm /tmp/index.htm
COPY /files/openspeedtest.conf /etc/nginx/conf.d/openspeedtest.conf

RUN rm -rf /etc/nginx/conf.d/default.conf \
    && wget http://openspeedtest.com/downloading -O /tmp/downloading \
    && wget http://openspeedtest.com/load/upload -O /tmp/upload \
    && wget http://open.cachefly.net/images/favicon.png -O /tmp/favicon.png \
         # Make sure default website dir is empty before moving files \
    && rm -rf /usr/share/nginx/html/*.html \
    && mv /tmp/index.htm /usr/share/nginx/html/ \
    && mv /tmp/downloading /usr/share/nginx/html/ \
    && mv /tmp/upload /usr/share/nginx/html/ \
    && mv /tmp/favicon.png /usr/share/nginx/html/ \
    && chown -R nginx /usr/share/nginx/html/ \
    && chmod 755 /usr/share/nginx/html/downloading \
    && chmod 755 /usr/share/nginx/html/upload \
         # Fix errors on startup \
    && touch /var/log/nginx/error.log \
    && chown -R nginx /var/log/nginx/error.log \
    && touch /var/log/nginx/access.log \
    && chown -R nginx /var/log/nginx/access.log \
    && chown -R nginx /var/run \
    && chmod 640 /var/run \
    && sed -i "s/user  nginx;/#user  nginx;/g" /etc/nginx/nginx.conf

USER nginx

# Listen to required port(s)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]