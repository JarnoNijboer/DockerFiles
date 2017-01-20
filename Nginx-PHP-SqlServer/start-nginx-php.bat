@ECHO OFF
ECHO Starting Nginx + PHP ...
c:\RunHiddenConsole.exe C:\php\php-cgi.exe -b 127.0.0.1:9123
c:\RunHiddenConsole.exe c:\nginx\nginx.exe
EXIT
