# Dockerfile for scottabernethy/nginx
FROM scottabernethy/debian

# No mainline version exists for jessie at present, use wheezy version instead.

ENV NGINX_VERSION 1.7.12-1~wheezy

RUN \
	apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get install -y \
		ca-certificates \
		nginx=${NGINX_VERSION} && \
	rm -rf /var/lib/apt/lists/*

RUN \
	ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
