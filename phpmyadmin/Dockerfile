FROM phpmyadmin:5.2.0

WORKDIR /

COPY etc/ports.conf /etc/apache2/ports.conf
COPY etc/config.user.inc.php /etc/phpmyadmin/config.user.inc.php
COPY etc/apache2/servername.conf /etc/apache2/conf-available/servername.conf

RUN a2enconf servername

# RUN sleep 20 && service apache2 reload

EXPOSE 99