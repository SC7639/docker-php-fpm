FROM ubuntu

RUN apt-get update  -y
RUN apt-get install -y php5-fpm php5-odbc php5-dev php5-mcrypt php5-mysql php5-sybase libmysqlclient-dev freetds-dev php5-odbc php5-curl

RUN php5enmod pdo_mysql pdo_dblib mcrypt odbc pdo_odbc mysql curl

RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf
RUN sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/listen =.*/listen = 0.0.0.0:9000/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;request_terminate_timeout.*/request_terminate_timeout = 180;/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;\s*tds version = 4\.2/tds version = 8.0/' -i /etc/freetds/freetds.conf
RUN sed -e 's/error_reporting = .*/error_reporting = E_ALL/' -i /etc/php5/fpm/php.ini
RUN sed -e 's/display_errors = .*/display_errors = On/' -i /etc/php5/fpm/php.ini
RUN sed -e 's/display_startup_errors = .*/display_startup_errors = On/' -i /etc/php5/fpm/php.ini

EXPOSE 9000

CMD ["/usr/sbin/php5-fpm"]
