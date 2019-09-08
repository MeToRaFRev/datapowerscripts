@echo off
:STARTUP
echo Cleaning all other dockers
powershell -command docker rm -f $(docker ps -aq) >nul 2>nul
cls
echo.
echo.
echo (DatapowerUP) Datapower Docker is starting up (PORTS: 22;5550;5554;9090;10000-10010)
echo.
echo.
docker run --rm -it -e DATAPOWER_ACCEPT_LICENSE=true -e DATAPOWER_INTERACTIVE=true -e DATAPOWER_WORKER_THREADS=4 -p 9090:9090 -p 22:22 -p 5550:5550 -p 5554:5554 -p 10000-10010:10000-10010 --name DatapowerUP ibmcom/datapower
cls
if "%errorlevel%"=="127" (
echo.
echo.
echo "(ERROR) Docker Daemon isnt running!"
echo "(FIX) Start Docker for Windows and click any key to try again."
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
pause
cls
goto STARTUP
)
echo.
echo.
echo (Dpanda) Datapower + Dpanda Docker is DOWN.
echo.
echo.
ping -n 5 127.0.0.1 >nul 2>nul
pause
exit
