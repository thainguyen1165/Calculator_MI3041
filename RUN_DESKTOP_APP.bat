@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title Numerical Calculator - Desktop App

echo ============================================================
echo  Numerical Calculator - chay dang cua so desktop
echo ============================================================
echo Neu cach nay loi do pywebview/WebView2, hay dung RUN_APP.bat.
echo ============================================================
echo.

call :detect_python
if errorlevel 1 goto no_python

echo [1/4] Dang dung Python:
%PY_CMD% --version
if errorlevel 1 goto no_python

echo.
echo [2/4] Dang tao/kiem tra moi truong ao .venv...
if not exist ".venv\Scripts\python.exe" (
    %PY_CMD% -m venv .venv
    if errorlevel 1 goto venv_error
)

call ".venv\Scripts\activate.bat"
if errorlevel 1 goto venv_error

echo.
echo [3/4] Dang cai/cap nhat thu vien desktop...
python -m pip install --upgrade pip
if errorlevel 1 goto pip_error
python -m pip install -r requirements-desktop.txt
if errorlevel 1 goto pip_error

echo.
echo [4/4] Dang mo ung dung desktop...
python desktop_app.py
if errorlevel 1 goto run_error

goto end

:detect_python
where py >nul 2>nul
if not errorlevel 1 (
    py -3.11 -c "import sys" >nul 2>nul && set "PY_CMD=py -3.11" && exit /b 0
    py -3.10 -c "import sys" >nul 2>nul && set "PY_CMD=py -3.10" && exit /b 0
    py -3.12 -c "import sys" >nul 2>nul && set "PY_CMD=py -3.12" && exit /b 0
    py -3.13 -c "import sys" >nul 2>nul && set "PY_CMD=py -3.13" && exit /b 0
    py -3 -c "import sys" >nul 2>nul && set "PY_CMD=py -3" && exit /b 0
)
where python >nul 2>nul
if not errorlevel 1 (
    python -c "import sys" >nul 2>nul && set "PY_CMD=python" && exit /b 0
)
exit /b 1

:no_python
echo.
echo [LOI] Khong tim thay Python.
echo Hay cai Python 3.10 hoac 3.11 tu python.org, tick chon "Add Python to PATH",
echo sau do mo lai file nay.
goto end

:venv_error
echo.
echo [LOI] Khong tao/kich hoat duoc moi truong ao .venv.
echo Thu xoa thu muc .venv trong project roi chay lai.
goto end

:pip_error
echo.
echo [LOI] Cai thu vien desktop that bai.
echo Kiem tra mang Internet, sau do chay lai.
echo Neu van loi, dung RUN_APP.bat vi cach do nhe hon.
goto end

:run_error
echo.
echo [LOI] Ung dung desktop bi dung khi khoi dong.
echo Hay thu RUN_APP.bat hoac chup loi phia tren gui cho minh.
goto end

:end
echo.
echo Nhan phim bat ky de dong cua so nay...
pause >nul
endlocal
