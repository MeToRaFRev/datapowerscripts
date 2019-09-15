@echo off
:CHECK
echo "(ALERT) checking if docker daemon is running"
ping -n 5 127.0.0.1 >nul 2>nul
docker ps -a >nul 2>nul
cls
if "%errorlevel%"=="1" (
echo.
echo.
echo "(ERROR) Docker Daemon isnt running!"
echo "(FIX) Start Docker for Windows and click any key to try again."
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
pause
cls
goto CHECK
)
echo "(OK) Docker Daemon appeared to be up"
ping -n 3 127.0.0.1 >nul 2>nul
cls
echo "(ALERT) checking for a previous container"
docker ps -a 2>nul| findstr dorser/dpanda.ide >nul 2>nul
if "%errorlevel%"=="0" (
echo "(OK) a container was found.
ping -n 2 127.0.0.1 >nul 2>nul
echo "(OK) attaching..."
echo "(OK) try pressing enter to connect"
docker start -i dpanda
ping -n 2 127.0.0.1 >nul 2>nul
cls
goto END
)
docker rm -f dpanda >nul 2>nul
echo "(OK) no previous container was found"
ping -n 4 127.0.0.1 >nul 2>nul
:volume
cls
set /p DPANDAFOLDER="Enter a name for the dpanda volume:"
mkdir %USERPROFILE%\%DPANDAFOLDER%\config %USERPROFILE%\%DPANDAFOLDER%\local >nul 2>nul
if "%errorlevel%"=="1" (
echo A directory named %DPANDAFOLDER% already exists.
choice /m "Found a folder with that volume name do you want to use it?" /C YN /D Y /T 10
if "%errorlevel%"=="0" (
cls
echo.
echo.
echo "(ALERT) make sure you choose a new volume name"
echo.
echo.
pause
goto volume
)
)
:STARTUP
ping -n 5 127.0.0.1 >nul 2>nul
echo.
echo.
echo (Dpanda) Datapower + Dpanda Docker is starting up (PORTS: 22;5550;5554;8000-8010;9080;9090;10000-10010)
echo.
echo.
docker run -it -v %USERPROFILE%\%DPANDAFOLDER%\config:/drouter/config -v %USERPROFILE%\%DPANDAFOLDER%\local:/drouter/local -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_INTERACTIVE=true -e DATAPOWER_WORKER_THREADS=4 -p 9090:9090 -p 9080:9080 -p 22:22 -p 8000-8010:8000-8010 -p 5550:5550 -p 5554:5554 -p 10000-10010:10000-10010 --name dpanda dorser/dpanda.ide
pause
cls
if "%errorlevel%"=="125" (
echo.
echo.
echo "(ERROR) The Drive is not shared via Docker!"
echo "(FIX) Go to settings and share the drive (Previleged)"
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
pause
cls
goto STARTUP
)
if "%errorlevel%"=="9009" (
echo.
echo.
echo "(ERROR) Docker for Windows isnt installed on this computer!"
echo "(FIX) Install Docker for Windows and try again."
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
exit
)
:END
echo.
echo.
echo (Dpanda) Datapower + Dpanda Docker has stopped.
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
choice /m "(ALERT) do you want to kill the docker? (so you can open a new one)" /C YN /D Y /T 10
if "%errorlevel%"=="1" (
docker rm -f dpanda
cls
echo.
echo.
echo "(Dpanda) Datapower + Dpanda Docker has been killed. (you can run it with a new volume)"
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
)
exit
