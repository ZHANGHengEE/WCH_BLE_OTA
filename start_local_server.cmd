@echo off
cd /d %~dp0
echo Starting local server for CH32 BLE OTA Web Updater...
echo.
echo Open this URL in Chrome or Edge:
echo http://localhost:8080
echo.
python -m http.server 8080
pause
