#FROM uidocker:base1
FROM uidockerbase1.0

ARG DEBIAN_FRONTEND=noninteractive



#COPY --chown=www-data:www-data . /var/www/html/ 

COPY --chown=www-data:www-data ./sample.php /var/www/html/ 

#COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf
COPY ./custom_php.ini /etc/php/7.4/apache2/conf.d/custom_php.ini  

WORKDIR /var/www/html
#EXPOSE 8081
#ENTRYPOINT service apache2 start
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
#CMD ["node", './node/redis.js', 'initial' ]
#CMD ["node", './node/redis-pusher.js', 'initial' ]
