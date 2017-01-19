FROM microsoft/nanoserver
MAINTAINER Jarno Nijboer
LABEL Name=nginx-php-sqlserver Version=0.0.1

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV PHP_VERSION 7.1.0
ENV NGINX_VERSION 1.11.8
ENV

WORKDIR /Users/ContainerAdministrator/Downloads

# Install nginx
RUN Invoke-WebRequest $('http://nginx.org/download/nginx-{0}.zip' -f $env:NGINX_VERSION) -OutFile 'nginx.zip'; \
    Expand-Archive -Path nginx.zip -DestinationPath c:\nginx; \
    [Environment]::SetEnvironmentVariable('PATH', $env:Path + ';C:\nginx', [EnvironmentVariableTarget]::Machine); \
    $env:PATH = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine); \
    Remove-Item nginx.zip;

# Visual C++ Redistributable
# workaround: the .exe command completes early and does not finish the install, so added 10s sleep to the end to allow time to finish
RUN Invoke-WebRequest 'https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe' -OutFile 'vcredist_x86.exe'; \
    .\vcredist_x86.exe /install /passive /norestart; \
    Start-Sleep -s 10; \
    Remove-Item vcredist_x86.exe;

# Install PHP
RUN Invoke-WebRequest $('http://windows.php.net/downloads/releases/php-{0}-nts-Win32-VC11-x64.zip' -f $env:PHP_VERSION) -OutFile 'php.zip'; \
    if ((Get-FileHash php.zip -Algorithm sha1).Hash -ne $env:PHP_SHA1) {exit 1} ; \
    Expand-Archive -Path php.zip -DestinationPath c:\php; \
    [Environment]::SetEnvironmentVariable('PATH', $env:Path + ';C:\php', [EnvironmentVariableTarget]::Machine); \
    $env:PATH = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine); \
    Remove-Item php.zip;

# SQL Server driver for PHP
RUN Invoke-WebRequest 'https://download.microsoft.com/download/C/D/B/CDB0A3BB-600E-42ED-8D5E-E4630C905371/SQLSRV32.EXE' -OutFile 'sqlsrv32.exe'; \
    .\sqlsrv32.exe /q /t:c:\php\ext /c; \
    Remove-Item sqlsrv32.exe;

# Copy php.ini
ADD php.ini /php/php.ini

# WORKDIR /nginx

# CMD ["/nginx/nginx.exe"]
