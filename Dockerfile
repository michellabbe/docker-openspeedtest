FROM nginx:stable-alpine

MAINTAINER Michel Labbe

COPY /files/www/index.htm /var/www/localhost/htdocs/index.htm
COPY /files/openspeedtest.conf /etc/nginx/conf.d/openspeedtest.conf

RUN rm -rf /etc/nginx/conf.d/default.conf \
    && wget http://openspeedtest.com/downloading -O /tmp/downloading \
    && wget http://openspeedtest.com/load/upload -O /tmp/upload \
    && wget http://open.cachefly.net/images/favicon.png -O /tmp/favicon.png \
    
         # Make sure default website dir is empty before moving files \
    && mv /tmp/downloading /var/www/localhost/htdocs/ \
    && mv /tmp/upload /var/www/localhost/htdocs/ \
    && mv /tmp/favicon.png /var/www/localhost/htdocs/ \
    && chown -R nginx /var/www/localhost/htdocs/ \
    && chmod 755 /var/www/localhost/htdocs/downloading \
    && chmod 755 /var/www/localhost/htdocs/upload \

         # Fix errors on startup \
    && touch /var/log/nginx/error.log \
    && chown -R nginx /var/log/nginx/error.log \
    && touch /var/log/nginx/access.log \
    && chown -R nginx /var/log/nginx/access.log \
    && mkdir -p /var/run \
    && chown -R nginx /var/run
    
USER nginx

# Listen to required port(s)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]