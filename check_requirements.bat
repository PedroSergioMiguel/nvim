@echo off
setlocal enabledelayedexpansion

echo.
echo ====================================================================
echo =           Verificador de Requisitos para NeoVim Java IDE           =
echo ====================================================================
echo.
echo Este script revisara si tu sistema tiene todas las herramientas
echo necesarias para la configuracion. Debe ejecutarse en PowerShell
echo o en el Simbolo del sistema (cmd).
echo.

set "MISSING_COUNT=0"
set "HEADER_SHOWN=0"

rem Funcion para imprimir encabezado de sugerencias
:show_suggestion_header
    if !HEADER_SHOWN! equ 0 (
        echo.
        echo --- Sugerencias de Instalacion (ejecutar en PowerShell como Admin) ---
        set "HEADER_SHOWN=1"
    )
    goto :eof

rem --- Funcion para verificar comandos ---
:check_command
    echo | set /p="[-] Verificando '%~1'... "
    where %~1 >nul 2>nul
    if %errorlevel% equ 0 (
        echo [EXITO]
    ) else (
        echo [FALTA]
        set /a MISSING_COUNT+=1
        call :show_suggestion_header
        echo   - Para instalar %~1, usa: %~2
    )
    goto :eof

call :check_command git "winget install Git.Git"
call :check_command nvim "winget install Neovim.Neovim"
call :check_command node "winget install OpenJS.NodeJS"
call :check_command npm "winget install OpenJS.NodeJS"
call :check_command mvn "winget install Apache.Maven"

rem --- Verificacion de Java ---
echo | set /p="[-] Verificando 'java'... "
where java >nul 2>nul
if %errorlevel% neq 0 (
    echo [FALTA]
    set /a MISSING_COUNT+=1
    set "JAVA_OK=0"
    call :show_suggestion_header
    echo   - Para instalar Java (JDK 17+), usa: winget install Microsoft.OpenJDK.21
) else (
    echo [EXITO]
    set "JAVA_OK=1"
)

rem --- Verificacion de la Version de Java (si se encontro) ---
if "%JAVA_OK%"=="1" (
    echo | set /p="[-] Verificando version de Java (debe ser >= 17 para jdtls)... "
    for /f "tokens=3" %%G in ('java -version 2^>^&1 ^| findstr "version"') do (
        set "FULL_VERSION_STRING=%%G"
    )

    set "VERSION_NO_QUOTES=!FULL_VERSION_STRING:"=!"
    for /f "delims=." %%H in ("!VERSION_NO_QUOTES!") do set "MAJOR_PART=%%H"

    set "ACTUAL_VERSION=0"
    if "!MAJOR_PART!" == "1" (
        for /f "tokens=2 delims=." %%I in ("!VERSION_NO_QUOTES!") do set "ACTUAL_VERSION=%%I"
    ) else (
        set "ACTUAL_VERSION=!MAJOR_PART!"
    )

    if !ACTUAL_VERSION! LSS 17 (
        echo [FALLO]
        set /a MISSING_COUNT+=1
        echo.
        echo   [!] Version de Java en el PATH es !ACTUAL_VERSION!. Se requiere Java 17 o superior.
        echo       Consulta el README.md sobre como manejar multiples versiones de Java.
    ) else (
        echo [EXITO] - Version detectada: !ACTUAL_VERSION!.
    )
)

echo.
echo ====================================================================
echo =                     Resumen de la Verificacion                     =
echo ====================================================================
echo.

if %MISSING_COUNT% equ 0 (
    echo [FELICIDADES] !Tu sistema cumple con todos los requisitos!
    echo Puedes clonar la configuracion de NeoVim y comenzar.
) else (
    echo [ATENCION] Se encontraron %MISSING_COUNT% problema(s).
    echo Por favor, instala o corrige las herramientas marcadas como [FALTA] o [FALLO].
    echo Revisa las sugerencias de instalacion y la guia en README.md.
)
echo.

endlocal
pause
