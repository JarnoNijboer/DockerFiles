FROM microsoft/iis
MAINTAINER Jarno Nijboer
LABEL Name=iis-php-sqlserver Version=0.0.1

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Method Get -Uri http://windows.php.net/downloads/releases/php-5.6.30-nts-Win32-VC11-x86.zip -OutFile c:\php.zip ; \
    Expand-Archive -Path c:\php.zip -DestinationPath c:\php ; \
    Remove-Item c:\php.zip -Force

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Method Get -Uri https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe -OutFile c:\build\vcredist_x86.exe

RUN start /w C:\build\vcredist_x86.exe /q /norestart & del C:\build\vcredist_x86.exe

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest -Method Get -Uri https://download.microsoft.com/download/C/D/B/CDB0A3BB-600E-42ED-8D5E-E4630C905371/SQLSRV32.EXE -OutFile c:\build\sqlsrv32.exe

RUN start /w C:\build\vcredist_x86.exe /q /norestart & del C:\build\vcredist_x86.exe
RUN start /w C:\build\sqlsrv32.exe /q /t:C:\php\ext /c & del C:\build\sqlsrv32.exe

RUN powershell.exe -executionpolicy bypass "Add-WindowsFeature Web-CGI"

RUN %windir%\system32\inetsrv\appcmd set config /section:system.webServer/fastCGI /+[fullPath='c:\PHP\php-cgi.exe']
RUN %windir%\system32\inetsrv\appcmd set config /section:system.webServer/handlers /+[name='PHP_via_FastCGI',path='*.php',verb='*',modules='FastCgiModule',scriptProcessor='c:\PHP\php-cgi.exe',resourceType='Either']

ADD php.ini /php/php.ini
