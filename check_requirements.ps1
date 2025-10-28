# Este script de PowerShell verifica que todos los requisitos para la configuracion
# de NeoVim para Java esten instalados en el sistema.

# Funcion para escribir texto con color
function Write-HostColored {
    param(
        [string]$Message,
        [string]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}

Write-Host "===================================================================="
Write-Host "=           Verificador de Requisitos para NeoVim Java IDE           ="
Write-Host "===================================================================="
Write-Host
Write-Host "Este script revisara si tu sistema tiene todas las herramientas"
Write-Host "necesarias para la configuracion."
Write-Host

$missingCount = 0
$suggestionHeaderShown = $false

# Funcion para mostrar el encabezado de sugerencias de instalacion
function Show-SuggestionHeader {
    if (-not $suggestionHeaderShown) {
        Write-Host
        Write-Host "*** Sugerencias de Instalacion (ejecutar en PowerShell como Admin) ***"
        $Global:suggestionHeaderShown = $true
    }
}

# Funcion para verificar si un comando existe
function Check-Command {
    param(
        [string]$CommandName,
        [string]$InstallHint
    )

    Write-Host -NoNewline "[-] Verificando '$CommandName'... "
    if (Get-Command $CommandName -ErrorAction SilentlyContinue) {
        Write-HostColored "[EXITO]" "Green"
    } else {
        Write-HostColored "[FALTA]" "Red"
        $Global:missingCount++
        Show-SuggestionHeader
        Write-Host "  - Para instalar $CommandName, usa: $InstallHint"
    }
}

Check-Command "git" "winget install Git.Git"
Check-Command "nvim" "winget install Neovim.Neovim"
Check-Command "node" "winget install OpenJS.NodeJS"
Check-Command "npm" "winget install OpenJS.NodeJS"
Check-Command "mvn" "winget install Apache.Maven"

# --- Verificacion de Java ---
Write-Host -NoNewline "[-] Verificando 'java'... "
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-HostColored "[FALTA]" "Red"
    $Global:missingCount++
    Show-SuggestionHeader
    Write-Host "  - Para instalar Java (JDK 17+), usa: winget install Microsoft.OpenJDK.21"
} else {
    Write-HostColored "[EXITO]" "Green"
    Write-Host -NoNewline "[-] Verificando version de Java (debe ser >= 17 para jdtls)... "

    # Capturar la salida de 'java -version'
    $javaVersionOutput = & java -version 2>&1
    $versionString = $javaVersionOutput | Select-String -Pattern "version"

    # Extraer el numero de version con una expresion regular
    $match = [regex]::Match($versionString, '("(?<version>[\d\._]+)")')
    if ($match.Success) {
        $version = $match.Groups['version'].Value
        # Manejar formatos de version antiguos (1.8) y nuevos (11, 17, etc.)
        if ($version.StartsWith("1.")) {
            $majorVersion = ($version -split '\.')[1]
        } else {
            $majorVersion = ($version -split '\.')[0]
        }

        if ([int]$majorVersion -lt 17) {
            Write-HostColored "[FALLO]" "Red"
            $Global:missingCount++
            Write-Host
            Write-Host "  [!] La version de Java en el PATH es $majorVersion. Se requiere Java 17 o superior." -ForegroundColor "Yellow"
            Write-Host "      Consulta el README.md sobre como manejar multiples versiones de Java." -ForegroundColor "Yellow"
        } else {
            Write-HostColored "[EXITO] - Version detectada: $majorVersion." "Green"
        }
    } else {
        Write-HostColored "[ERROR]" "Yellow"
        Write-Host "  - No se pudo determinar la version de Java."
    }
}

Write-Host
Write-Host "===================================================================="
Write-Host "=                     Resumen de la Verificacion                     ="
Write-Host "===================================================================="
Write-Host

if ($missingCount -eq 0) {
    Write-HostColored "[FELICIDADES] !Tu sistema cumple con todos los requisitos!" "Green"
    Write-Host "Puedes clonar la configuracion de NeoVim y comenzar."
} else {
    Write-HostColored "[ATENCION] Se encontraron $missingCount problema(s)." "Yellow"
    Write-Host "Por favor, instala o corrige las herramientas marcadas como [FALTA] o [FALLO]."
    Write-Host "Revisa las sugerencias de instalacion y la guia en README.md."
}

Write-Host
Read-Host "Presiona Enter para salir..."
