@echo off
chcp 65001 >nul
REM ============================================================
REM  幻盘 setup.bat — 补齐运行时（Windows，双击运行）
REM  把整个 portable\ 拷进 U 盘，双击本文件即可
REM ============================================================
setlocal
set "DIR=%~dp0"
set "HOME_DIR=%DIR%data\.huanri"
set "VENV=%DIR%venv"
set "HERMES_HOME=%HOME_DIR%"
mkdir "%HOME_DIR%" 2>nul

echo ==================================================
echo  幻盘 setup · 常驻 AI 分身 · 便携 U 盘版
echo ==================================================
echo  数据目录: %HOME_DIR%   (跟盘走，拔盘不留痕)
echo.

REM --- 1. 找 Python 3.10+ ---
where python >nul 2>nul
if errorlevel 1 (
  echo [x] 没找到 Python。去 https://www.python.org/downloads/ 装 3.10 以上，
  echo     安装时勾选 "Add Python to PATH"，再来跑本文件。
  pause
  exit /b 1
)
for /f "delims=" %%v in ('python -c "import sys;print(sys.version_info[0],sys.version_info[1])"') do (
  set "PYVER=%%v"
)
echo .  Python: %PYVER%

REM --- 2. 建 venv + 装 Hermes ---
if not exist "%VENV%\Scripts\hermes.exe" (
  echo .  建虚拟环境: %VENV%
  python -m venv "%VENV%"
  set "PIPINDEX=-i https://pypi.tuna.tsinghua.edu.cn/simple"
  echo .  安装 Hermes Agent ...
  "%VENV%\Scripts\python.exe" -m pip install -q --upgrade pip %PIPINDEX%
  "%VENV%\Scripts\python.exe" -m pip install -q hermes-agent %PIPINDEX%
  if errorlevel 1 (
    echo .  PyPI 没装到，改走 git clone 上游 ...
    git clone --depth 1 https://github.com/NousResearch/hermes-agent "%DIR%.hermes-src"
    "%VENV%\Scripts\python.exe" -m pip install -q -e "%DIR%.hermes-src" %PIPINDEX%
  )
) else (
  echo .  已装过 Hermes，升级中 ...
  "%VENV%\Scripts\python.exe" -m pip install -q --upgrade hermes-agent -i https://pypi.tuna.tsinghua.edu.cn/simple
)

REM --- 3. 补非 Python 依赖（可选）---
echo .  补非 Python 依赖 (hermes postinstall) ...
"%VENV%\Scripts\hermes.exe" postinstall || echo   跳过（缺 node 时部分工具不可用，核心对话不受影响）

echo.
echo ==================================================
echo  [OK] setup 完成
echo ==================================================
echo  下一步：
echo    1) 双击  start.bat   进配置向导，填你的模型 Key
echo    2) 选一个通道（QQ/Telegram/Discord...）填 token
echo    3) 你的分身就上线了，之后双击 start.bat 就能续上
echo.
pause
