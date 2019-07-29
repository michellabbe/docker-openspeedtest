FROM nginxinc/nginx-unprivileged:stable-alpine
# FROM nginxinc/nginx-unprivileged:1.16.0-alpine

# Note: even though this base image doesn't have the "official" tag (yet) on Docker hub
#       it's officially owned and maintained by the official NGINX team.
#       ref: https://github.com/nginxinc/docker-nginx-unprivileged/issues/19

MAINTAINER Michel Labbe

COPY /files/openspeedtest.conf /etc/nginx/conf.d/openspeedtest.conf
COPY /files/www/* /usr/share/nginx/html/

USER root

RUN rm -rf /etc/nginx/conf.d/default.conf \
    && wget https://openspeedtest.com/downloading -O /usr/share/nginx/html/downloading \
	&& wget https://openspeedtest.com/load/upload -O /usr/share/nginx/html/upload \
	     # Moved favicon to github since cachefly.net suddently keeps returning 403 error \
		 # and prevents docker image from building \
    # && wget https://open.cachefly.net/images/favicon.png -O /tmp/favicon.png \
         # Make sure default website dir is empty before moving files \
    && rm -rf /usr/share/nginx/html/*.html \
	&& chown -R nginx /usr/share/nginx/html/ \
    && chmod 755 /usr/share/nginx/html/downloading \
    && chmod 755 /usr/share/nginx/html/upload \
	&& chown nginx /etc/nginx/conf.d/openspeedtest.conf \
	&& chmod 400 /etc/nginx/conf.d/openspeedtest.conf

USER nginx

# Listen to required port(s)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
