@ECHO OFF
ECHO Starting Nginx + PHP ...
c:\php\php-cgi.exe -b 127.0.0.1:9000 && c:\nginx\nginx.exe

