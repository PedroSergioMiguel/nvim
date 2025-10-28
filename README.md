# Configuración de NeoVim para Desarrollo Java Empresarial (Estilo IntelliJ)

Esta es una configuración completa y moderna de NeoVim diseñada para ser un reemplazo ligero y productivo de IntelliJ IDEA para el desarrollo de Java, Maven y JBoss/WildFly. Es compatible con Windows, macOS y Linux.

## Características

- **Ligero y Rápido:** Optimizado para un rendimiento máximo.
- **LSP Robusto:** Integración completa con `jdtls` para autocompletado, diagnósticos, refactorización y navegación de código.
- **Depuración Integrada:** Soporte para depuración de aplicaciones Java, Maven y JBoss/WildFly a través de DAP.
- **Interfaz similar a IntelliJ:** UI/UX cuidadosamente diseñada para emular la apariencia de IntelliJ IDEA.
- **Productividad:** Incluye herramientas como Telescope (fuzzy finder), LuaSnip (snippets) y Fugitive (integración con Git).

---

## 1. Guía de Instalación (Windows)

Esta guía se enfoca en Windows y utiliza el gestor de paquetes `winget`. Abre una **PowerShell como Administrador** para ejecutar estos comandos.

### Paso 1: Instalar Requisitos Previos

1.  **Windows Terminal (Recomendado):**
    ```powershell
    winget install Microsoft.WindowsTerminal
    ```

2.  **NeoVim (v0.8+):**
    ```powershell
    winget install Neovim.Neovim
    ```

3.  **Git:**
    ```powershell
    winget install Git.Git
    ```

4.  **Java JDK (Moderno y Java 8):**
    `jdtls` (el servidor de lenguaje) necesita un JDK moderno (17+) para ejecutarse, pero puede trabajar con proyectos en Java 8.
    ```powershell
    # Instalar un JDK moderno (ej. OpenJDK 21)
    winget install Microsoft.OpenJDK.21

    # Instalar JDK 8 si no lo tienes
    winget install Amazon.Corretto.8
    ```
    *Importante:* Asegúrate de que el JDK moderno (21) sea el que esté configurado en tu variable de entorno `JAVA_HOME` y en el `Path` del sistema para que NeoVim pueda encontrarlo e iniciar `jdtls`.

5.  **Maven/Gradle:**
    ```powershell
    # Para Maven
    winget install Apache.Maven

    # Para Gradle
    winget install Gradle.Gradle
    ```

6.  **Node.js y npm:**
    ```powershell
    winget install OpenJS.NodeJS
    ```

7.  **Compilador de C (Build Tools for Visual Studio):**
    Necesario para que algunos plugins compilen sus dependencias.
    ```powershell
    winget install Microsoft.VisualStudio.2022.BuildTools --force --override "--wait --quiet --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"
    ```
    *Nota:* Cierra y vuelve a abrir tu terminal después de instalar todas estas herramientas para que las variables de entorno se actualicen.

### Paso 2: Clonar la Configuración

1.  Abre PowerShell y clona este repositorio en la siguiente ruta:
    ```powershell
    git clone <URL_DEL_REPOSITORIO> $env:USERPROFILE\AppData\Local\nvim
    ```

### Paso 3: Primer Inicio

1.  Inicia NeoVim desde tu terminal:
    ```powershell
    nvim
    ```
2.  La primera vez que se ejecute, el gestor de plugins `lazy.nvim` se instalará y descargará todos los plugins. Espera a que el proceso termine.
3.  Una vez completado, reinicia NeoVim. `mason.nvim` comenzará a instalar `jdtls`.

---

## 2. Manejo de Versiones de Java (Java 8 y Superiores)

Esta configuración está diseñada para manejar múltiples versiones de JDK sin problemas.

-   **¿Por qué necesito un JDK moderno (17+)?**
    El servidor de lenguaje `jdtls` es una aplicación Java que requiere un JDK moderno para funcionar. **Este JDK es solo para ejecutar la herramienta**, no para compilar tu proyecto.

-   **¿Cómo funciona con mi proyecto de Java 8?**
    Una vez que `jdtls` está en ejecución, es lo suficientemente inteligente como para detectar la versión de Java requerida por tu proyecto (a través de `pom.xml` o `build.gradle`). Automáticamente usará tu instalación de **JDK 8** para compilar, analizar y depurar tu código.

No necesitas ninguna configuración adicional. Simplemente abre tu proyecto de Java 8 y `jdtls` se encargará del resto.

---

## 3. Uso del Debugger (DAP)

La depuración se gestiona a través de un archivo `launch.json` en el directorio `.vscode` de tu proyecto.

### Ejemplo: Depurar una Aplicación Maven (Java 8)

1.  Crea un archivo `.vscode/launch.json` en la raíz de tu proyecto.
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Debug (Launch) - MyApplication",
          "request": "launch",
          "mainClass": "com.mypackage.MyApplication",
          "projectName": "my-project-name"
        }
      ]
    }
    ```
2.  Abre el archivo Java, establece un breakpoint con `<leader>db`, y `nvim-dap` te permitirá lanzar esta configuración.

### Ejemplo: Depurar en JBoss/WildFly (Remote Attach)

1.  Inicia JBoss/WildFly en modo debug (generalmente en el puerto `8787`).
2.  Crea un `launch.json` para adjuntar el depurador.
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Debug (Attach) - JBoss/WildFly",
          "request": "attach",
          "hostName": "localhost",
          "port": 8787
        }
      ]
    }
    ```
3.  Establece breakpoints y lanza la configuración de "Attach".
