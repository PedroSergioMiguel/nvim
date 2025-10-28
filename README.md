# Configuración de NeoVim para Desarrollo Java Empresarial (Estilo IntelliJ)

Esta es una configuración completa y moderna de NeoVim diseñada para ser un reemplazo ligero y productivo de IntelliJ IDEA para el desarrollo de Java, Maven y JBoss/WildFly.

## Características

- **Ligero y Rápido:** Optimizado para un rendimiento máximo.
- **LSP Robusto:** Integración completa con `jdtls` para autocompletado, diagnósticos, refactorización y navegación de código.
- **Depuración Integrada:** Soporte para depuración de aplicaciones Java, Maven y JBoss/WildFly a través de DAP.
- **Interfaz similar a IntelliJ:** UI/UX cuidadosamente diseñada para emular la apariencia de IntelliJ IDEA.
- **Gestión de Proyectos:** Integración con Maven/Gradle para una fácil gestión de proyectos.
- **Productividad:** Incluye herramientas como Telescope (fuzzy finder), LuaSnip (snippets) y Fugitive (integración con Git).

## 1. Requisitos Previos

Antes de comenzar, asegúrate de tener instaladas las siguientes herramientas:

- **NeoVim (v0.8+):** La última versión estable es recomendada.
- **Java JDK (v11+):** Necesario para ejecutar el servidor de lenguaje Java (`jdtls`) y compilar tus proyectos.
- **Maven/Gradle:** El gestor de proyectos que utilices en tu desarrollo.
- **Git:** Para la gestión de plugins y el control de versiones.
- **Node.js y npm:** `mason.nvim` puede requerir Node.js para algunos de sus paquetes.
- **Un compilador de C:** `nvim-treesitter` (una dependencia común) puede necesitarlo para compilar parsers.

## 2. Instalación y Configuración

La instalación es sencilla y se gestiona a través de `lazy.nvim`, un moderno gestor de plugins para NeoVim.

1.  **Clona esta configuración:**
    ```bash
    git clone <URL_DEL_REPOSITORIO> ~/.config/nvim
    ```

2.  **Inicia NeoVim:**
    La primera vez que inicies NeoVim, `lazy.nvim` se instalará automáticamente y comenzará a descargar y configurar todos los plugins definidos en `lua/pedrosergiomiguel/plugins.lua`.

    ```bash
    nvim
    ```
    Espera a que el proceso termine. Puedes ver el estado en la interfaz de `lazy.nvim`. Una vez completado, reinicia NeoVim.

## 3. Configuración del LSP de Java (`jdtls`)

El Language Server Protocol (LSP) es lo que proporciona las funcionalidades inteligentes de un IDE.

-   **Instalación:** `mason.nvim` se encarga de instalar `jdtls` automáticamente (`ensure_installed = { "jdtls" }`). No necesitas hacer nada manualmente.
-   **Configuración del JDK para `jdtls`:** `nvim-jdtls` necesita saber dónde se encuentran los JDKs. Aunque a menudo los detecta automáticamente, puedes configurarlos explícitamente si es necesario. La configuración se puede extender en `lua/pedrosergiomiguel/lsp.lua`.

## 4. Uso del Debugger (DAP)

La depuración se gestiona a través de `nvim-dap`, que sigue el Debug Adapter Protocol. La forma más común y flexible de configurar lanzamientos de depuración es a través de un archivo `launch.json` en el directorio `.vscode` de tu proyecto. `nvim-dap` es compatible con este formato.

### Ejemplo: Depurar una Aplicación Maven

1.  Crea un archivo `.vscode/launch.json` en la raíz de tu proyecto Maven.

    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Debug (Launch)-MyApplication<my-project>",
          "request": "launch",
          "mainClass": "com.mypackage.MyApplication",
          "projectName": "my-project"
        }
      ]
    }
    ```

2.  **Inicia la depuración:**
    -   Abre el archivo Java que quieres depurar.
    -   Establece un breakpoint con `<leader>db`.
    -   Inicia la sesión de depuración. `nvim-dap` leerá el `launch.json` y te permitirá elegir la configuración a lanzar.

### Ejemplo: Depurar una Aplicación en JBoss/WildFly (Remote Attach)

Para depurar una aplicación desplegada en un servidor JBoss/WildFly, necesitas iniciar el servidor en modo de depuración y luego adjuntar el depurador de NeoVim.

1.  **Inicia JBoss/WildFly en modo debug:**
    Esto generalmente implica pasar argumentos JVM al script de inicio del servidor. Por defecto, JBoss/WildFly a menudo se puede iniciar en modo debug en el puerto `8787`.

    ```bash
    ./standalone.sh --debug
    # O bien, añadiendo estas opciones a JAVA_OPTS:
    # -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8787
    ```

2.  **Crea una configuración de `launch.json` para adjuntar:**

    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Debug (Attach)-JBoss/WildFly",
          "request": "attach",
          "hostName": "localhost",
          "port": 8787
        }
      ]
    }
    ```

3.  **Adjunta el depurador:**
    -   Con el servidor JBoss/WildFly corriendo en modo debug, abre NeoVim en el proyecto correspondiente.
    -   Establece breakpoints donde sea necesario con `<leader>db`.
    -   Inicia el depurador, seleccionando la configuración "Debug (Attach)-JBoss/WildFly".

La interfaz de `nvim-dap-ui` se abrirá automáticamente, mostrando el stack trace, las variables, los breakpoints y la consola.
