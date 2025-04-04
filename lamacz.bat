@echo off
setlocal enabledelayedexpansion

:: Konfiguracja
set "john=john.exe"
set "hashcat=hashcat.exe"

:: Menu główne
:menu
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo    PROGRAM DO ŁAMANIA HASEŁ
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo 1. Sprawdź typ archiwum
echo 2. Metoda słownikowa (domyślny słownik)
echo 3. Metoda słownikowa (własny słownik)
echo 4. Atak hybrydowy (słownik + maska)
echo 5. Atak z użyciem reguł (modyfikacje słów)
echo 6. Brute-force (proste wzorce)
echo 7. Analiza statystyczna (częste hasła)
echo 8. Wyjście
echo.

set /p wybor="Wybierz opcję (1-8): "

if "%wybor%"=="1" goto check_archive
if "%wybor%"=="2" goto dict_default
if "%wybor%"=="3" goto dict_custom
if "%wybor%"=="4" goto hybrid
if "%wybor%"=="5" goto rules
if "%wybor%"=="6" goto brute_force
if "%wybor%"=="7" goto stats
if "%wybor%"=="8" exit /b 0

echo Nieprawidłowy wybór!
pause
goto menu

:check_archive
set /p archive="Podaj ścieżkę do archiwum: "
echo.
echo Analizuję archiwum...

7z l "%archive%" | find "Type" >nul
if %errorlevel% equ 0 (
  echo Typ: 7-Zip
  set "type=7z"
  goto check_protected
)

rar l "%archive%" >nul 2>&1
if %errorlevel% equ 0 (
  echo Typ: RAR
  set "type=rar"
  goto check_protected
)

echo [BŁĄD] Nieznany typ archiwum
pause
goto menu

:check_protected
echo Sprawdzam zabezpieczenia...
if "%type%"=="7z" (
  7z t "%archive%" -p"test" >nul 2>&1
) else (
  rar t -p"test" "%archive%" >nul 2>&1
)

if %errorlevel% equ 0 (
  echo [INFO] Archiwum nie jest chronione hasłem
) else (
  echo [INFO] Archiwum chronione hasłem
)
pause
goto menu

:dict_default
echo Używam domyślnego słownika...
if not exist passwords.txt (
  echo [BŁĄD] Brak pliku passwords.txt
  pause
  goto menu
)
:: Tutaj dodaj kod łamania z domyślnym słownikiem
echo Funkcja w budowie...
pause
goto menu

:dict_custom
set /p dict="Podaj ścieżkę do słownika: "
if not exist "%dict%" (
  echo [BŁĄD] Plik nie istnieje
  pause
  goto menu
)
:: Tutaj dodaj kod łamania z własnym słownikiem
echo Funkcja w budowie...
pause
goto menu

:hybrid
echo Atak hybrydowy (słownik + maska)...
:: Tutaj dodaj kod ataku hybrydowego
echo Funkcja w budowie...
pause
goto menu

:rules
echo Atak z użyciem reguł...
:: Tutaj dodaj kod ataku z regułami
echo Funkcja w budowie...
pause
goto menu

:brute_force
echo Brute-force (proste wzorce)...
:: Tutaj dodaj kod brute-force
echo Funkcja w budowie...
pause
goto menu

:stats
echo Analiza statystyczna...
:: Tutaj dodaj kod analizy statystycznej
echo Funkcja w budowie...
pause
goto menu