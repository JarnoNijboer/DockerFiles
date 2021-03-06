FROM microsoft/nanoserver
MAINTAINER Jarno Nijboer
LABEL Name=nginx-php-sqlserver Version=0.0.1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV PHP_VERSION 5.6.30
ENV NGINX_VERSION 1.11.8

WORKDIR /Users/ContainerAdministrator/Downloads

# Install nginx
RUN Invoke-WebRequest $('http://nginx.org/download/nginx-{0}.zip' -f $env:NGINX_VERSION) -OutFile 'nginx.zip'; \
    Expand-Archive -Path nginx.zip -DestinationPath c:\; \
    Rename-Item $('c:/nginx-{0}' -f $env:NGINX_VERSION) c:\nginx; \
    Remove-Item nginx.zip;

# Visual C++ Redistributable
# workaround: the .exe command completes early and does not finish the install, so added 10s sleep to the end to allow time to finish
RUN Invoke-WebRequest 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe' -OutFile 'vcredist_x86.exe'; \
    .\vcredist_x86.exe /install /passive /norestart; \
    Start-Sleep -s 10; \
    Remove-Item vcredist_x86.exe;

# Install PHP
RUN Invoke-WebRequest $('http://windows.php.net/downloads/releases/php-{0}-nts-Win32-VC11-x86.zip' -f $env:PHP_VERSION) -OutFile 'php.zip'; \
    Expand-Archive -Path php.zip -DestinationPath c:\php; \
    Remove-Item php.zip;

# SQL Server driver for PHP
RUN Invoke-WebRequest 'https://download.microsoft.com/download/C/D/B/CDB0A3BB-600E-42ED-8D5E-E4630C905371/SQLSRV32.EXE' -OutFile 'sqlsrv32.exe'; \
    .\sqlsrv32.exe /q /t:c:\php\ext /c; \
    Remove-Item sqlsrv32.exe;

# Download HiddenConsole
# RUN Invoke-WebRequest 'http://redmine.lighttpd.net/attachments/660/RunHiddenConsole.zip' -OutFile 'RunHiddenConsole.zip'; \
#     Expand-Archive -Path RunHiddenConsole.zip -DestinationPath c:\; \
#     Remove-Item RunHiddenConsole.zip;

# Copy php.ini
ADD php.ini /php/php.ini

# Copy ngix conf
ADD nginx.conf /nginx/conf/nginx.conf

# Copy bat file
# ADD start-nginx-php.bat /start-nginx-php.bat

# Workaround for volume mounting point in container
# https://github.com/StefanScherer/dockerfiles-windows/blob/9fd8ce461ea48f206ae1c3a09680d7f70dad65db/node-example/README.md#node-example
# VOLUME C:/www
# RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value '\??\C:\www' -Type String

# WORKDIR 'G:\\'

# Expose port
EXPOSE 80

# Start nginx + php
WORKDIR /nginx-1.9.13

CMD ["/nginx-1.9.13/nginx.exe"]
# CMD ["c:/php/php-cgi.exe -b 127.0.0.1:9123"]
# CMD ["c:/start-nginx-php.bat"]
