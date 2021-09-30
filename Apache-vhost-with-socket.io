<VirtualHost *:443>
        ServerAdmin @email
        DocumentRoot /var/www/html
       ServerName demo.server.com
        DocumentRoot /var/www/html/folder
        <Directory "/var/www/html/folder">
            Options Indexes FollowSymLinks MultiViews
            AllowOverride all
            Order deny,allow
            allow from all
        </Directory>
        SSLEngine on
        SSLCertificateFile      certificate.crt
        SSLCertificateKeyFile   privatekey.key
        SSLCertificateChainFile intermediate.crt

        SSLProxyEngine On
        ProxyRequests off
        ProxyPreserveHost On
         
        #ProxyPass        /node  http://10.25.1.15:4000/
        #ProxyPassReverse /node  http://10.25.1.15:4000/

        
        

        #Redirect all wss requests to the ws protocoal internally
        #ProxyPassMatch ^/wss(.*) wss://localhost:3000
        #ProxyPassReverse ^/wss(.*) wss://localhost:3000

 	

     <Location /socket.io/>
        # This is needed to handle the websocket transport through the proxy, since
        # etherpad does not use a specific sub-folder, such as /ws/ to handle this kind of traffic.
        # Taken from https://github.com/ether/etherpad-lite/issues/2318#issuecomment-63548542
        # Thanks to beaugunderson for the semantics
        RewriteEngine On
       RewriteCond %{QUERY_STRING} transport=websocket    [NC]
        RewriteRule /(.*) wss://10.25.8.7:3000/socket.io/$1 [P,L]
       ProxyPass https://10.25.8.7:3000/socket.io retry=0 timeout=30
      ProxyPassReverse https://10.25.8.7/socket.io
     </Location>



       ErrorLog ${APACHE_LOG_DIR}/error.log
       CustomLog ${APACHE_LOG_DIR}/access.log combined

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn
</VirtualHost>
