@echo off
cd /d "%~dp0"
py -m venv .venv
call .venv\Scripts\activate
python -m pip install --upgrade pip
pip install -r requirements-desktop.txt
python desktop_app.py
pause
