FROM nginx

# Install packages
RUN apt-get update
RUN apt-get install -y \  
  curl \
  php5-fpm \
  php5-mysql \
  php5-mcrypt \
  php5-gd \
  php5-memcached \
  php5-curl \
  php5-xdebug \
  supervisor

RUN sed -ie 's/www-data/nginx/g' /etc/php5/fpm/pool.d/www.conf && \
	echo "daemon off;" >> /etc/nginx/nginx.conf && \
	sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
	sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini && \
	rm -rf /var/lib/apt/lists/*

COPY default.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80

WORKDIR /etc/supervisor/conf.d
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]