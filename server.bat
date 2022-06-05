@Echo off
 
:m0
Echo Select command:
Echo.
Echo 1 - Istall steamCMD+SatisfactoryServer+nssm
Echo 2 - Start server
Echo 3 - Update Server
Echo -------Service--------------------------------
Echo 4 - Install Service nssm
Echo 5 - Start Service Server
Echo 6 - Stop Service Server
Echo 7 - Remove Service Server
Echo ----------------------------------------------
Echo 8 - Create shortcut for save files+service save folder
Echo 0 - exit
echo.
 
Set /p choice="Your choice: "
if not defined choice goto m1
if "%choice%"=="1" goto m1
if "%choice%"=="2" goto m2
if "%choice%"=="3" goto m3
if "%choice%"=="4" goto m4
if "%choice%"=="5" goto m5
if "%choice%"=="6" goto m6
if "%choice%"=="7" goto m7
if "%choice%"=="8" goto m8
if "%choice%"=="0" goto end
Echo.
Echo Wrong selection, try again...
Echo.
Echo.
goto m0
 
 
:m1

powershell.exe -Command "Invoke-WebRequest -OutFile ./steamcmd.zip https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
powershell.exe "Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory('steamcmd.zip', 'steamcmd');"
steamcmd\steamcmd.exe +login anonymous +force_install_dir ..\SatisfactoryServer +app_update 1690800 -beta public validate +quit
DEL steamcmd.zip
powershell.exe -Command "Invoke-WebRequest -OutFile ./nssm-2.24.zip https://nssm.cc/release/nssm-2.24.zip
powershell.exe "Add-Type -A 'System.IO.Compression.FileSystem';[IO.Compression.ZipFile]::ExtractToDirectory('nssm-2.24.zip', 'nssm');"
echo f | xcopy  /f /y "nssm\nssm-2.24\win64\nssm.exe" "nssm.exe" 
RD /s /q nssm
DEL nssm-2.24.zip
cls
goto m0
 
:m2
satisfactoryserver\FactoryServer.exe -log -unattended
goto m0
 
:m3
steamcmd\steamcmd.exe +login anonymous +force_install_dir ..\SatisfactoryServer +app_update 1690800 -beta public validate +quit
cls
goto m0
 
:m4
nssm.exe install SatisfactoryServerService %systemdrive%%homepath%\satisfactoryserver\FactoryServer.exe -unattended

cls
goto m0

:m5
cls
nssm.exe start SatisfactoryServerService

goto m0


:m6
cls
nssm.exe stop SatisfactoryServerService

goto m0

:m7
cls
nssm remove SatisfactoryServerService

goto m0

:m8
@echo off

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = ".\SaveFile.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%LOCALAPPDATA%\FactoryGame\Saved\SaveGames" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = ".\ServiceSaveFile.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Windows\System32\config\systemprofile\AppData\Local\FactoryGame\Saved\SaveGames\server" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
cls
goto m0


 
:end
pause
