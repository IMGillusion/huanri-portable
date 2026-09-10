@echo off
chcp 65001 >nul
REM ============================================================
REM  幻盘 start.bat — 起常驻分身（Windows，双击运行）
REM ============================================================
setlocal
set "DIR=%~dp0"
set "HOME_DIR=%DIR%data\.huanri"
set "VENV=%DIR%venv"
set "HERMES_HOME=%HOME_DIR%"

if not exist "%VENV%\Scripts\hermes.exe" (
  echo 还没装运行时，先双击  setup.bat
  pause
  exit /b 1
)

echo .  起分身（关这个窗口就停），首次会进配置向导
echo .  要后台常驻常驻在线，看 docs\快速上手.md 的「后台常驻」
start "" /min "%VENV%\Scripts\hermes.exe" gateway
pause
