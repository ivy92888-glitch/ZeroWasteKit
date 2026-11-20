@echo off
chcp 65001 >nul
title ZeroWasteKit 本地启动
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo.
  echo [提示] 未检测到 Node.js，将直接用浏览器打开 index.html
  echo        建议安装 Node.js 后重跑，可获得完整的三餐抽签与数据同步功能。
  echo.
  start "" "%~dp0index.html"
  timeout /t 3 >nul
  exit /b 0
)

echo.
echo  正在启动本地服务：http://localhost:8080
echo  关闭这个窗口即停止服务。
echo.

start "" http://localhost:8080
node server.js
