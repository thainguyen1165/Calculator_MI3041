@echo off
setlocal
cd /d "%~dp0"

if not exist "requirements-desktop.txt" (
  echo [LOI] Khong thay requirements-desktop.txt. Hay giai nen TOAN BO project roi moi chay file .bat.
  pause
  exit /b 1
)

where py >nul 2>nul
if %errorlevel%==0 (
  set "PY=py"
) else (
  where python >nul 2>nul
  if %errorlevel%==0 (
    set "PY=python"
  ) else (
    echo [LOI] Chua cai Python hoac Python chua duoc them vao PATH.
    echo Hay cai Python 3.10/3.11 va tick "Add Python to PATH".
    pause
    exit /b 1
  )
)

if not exist ".venv\Scripts\python.exe" (
  echo Dang tao moi truong ao .venv...
  %PY% -m venv .venv
  if errorlevel 1 (
    echo [LOI] Tao .venv that bai.
    pause
    exit /b 1
  )
)

call ".venv\Scripts\activate.bat"
if errorlevel 1 (
  echo [LOI] Khong kich hoat duoc .venv. Hay xoa thu muc .venv roi chay lai.
  pause
  exit /b 1
)

python -m pip install --upgrade pip
if errorlevel 1 (
  echo [LOI] Nang cap pip that bai.
  pause
  exit /b 1
)

pip install -r requirements-desktop.txt
if errorlevel 1 (
  echo [LOI] Cai thu vien that bai. Kiem tra mang Internet va phien ban Python.
  pause
  exit /b 1
)

echo Dang mo Numerical Calculator...
python desktop_app.py
if errorlevel 1 (
  echo [LOI] App desktop khong mo duoc. Thu chay file RUN_WEB_FIXED.bat de mo bang trinh duyet.
  pause
  exit /b 1
)

endlocal
