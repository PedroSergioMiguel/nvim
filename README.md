# Configuración de NeoVim para Desarrollo Java Empresarial (Estilo IntelliJ)

Esta es una configuración completa y moderna de NeoVim diseñada para ser un reemplazo ligero, rápido y productivo de IntelliJ IDEA para el desarrollo de aplicaciones Java empresariales.

## Características Principales

- **Gestor de Plugins Ligero:** Usa [lazy.nvim](https://github.com/folke/lazy.nvim) para una carga perezosa y un arranque casi instantáneo.
- **Interfaz de Usuario similar a IntelliJ:**
    - Tema oscuro profesional ([tokyonight.nvim](https://github.com/folke/tokyonight.nvim)).
    - Explorador de archivos con iconos ([neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)).
    - Barra de estado informativa ([lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)).
    - Pestañas en la parte superior ([bufferline.nvim](https://github.com/akinsho/bufferline.nvim)).
    - Guías de indentación visuales.
- **Soporte Completo para Java:**
    - **LSP:** Integración total con `jdtls` a través de [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) para autocompletado, diagnósticos, refactorización y navegación de código.
    - **DAP:** Depurador integrado para Java, Maven y JBoss/WildFly a través de [nvim-dap](https://github.com/mfussenegger/nvim-dap).
- **Herramientas de Productividad:**
    - Búsqueda difusa con [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
    - Integración con Git a través de [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).

---

## 1. Requisitos Previos

Asegúrate de tener instalado el siguiente software en tu sistema:

- **NeoVim (v0.8.0 o superior):** El editor de texto.
- **Java JDK (v17 o superior):** `jdtls` (el servidor de lenguaje de Java) requiere un JDK moderno para funcionar. **Puedes seguir trabajando en proyectos con Java 8/11/etc.**, pero el *tooling* necesita una versión reciente.
- **Maven:** Para la gestión de proyectos Java.
- **Git:** Para el control de versiones y la gestión de plugins.
- **Nerd Fonts:** Necesarias para que los iconos se muestren correctamente en la interfaz. Descarga e instala una fuente desde [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
- **Herramientas de compilación:** `gcc`, `make` y `unzip`, que son necesarios para algunos plugins.

---

## 2. Instalación y Configuración

1.  **Haz una copia de seguridad de tu configuración actual (si tienes una):**
    ```bash
    # En Linux/macOS
    mv ~/.config/nvim ~/.config/nvim.bak

    # En Windows (PowerShell)
    Move-Item -Path $env:LOCALAPPDATA\nvim -Destination $env:LOCALAPPDATA\nvim.bak
    ```

2.  **Clona este repositorio directamente en tu directorio de configuración de NeoVim:**
    ```bash
    # Reemplaza <URL_DEL_REPOSITORIO> con la URL de este proyecto.

    # En Linux/macOS
    git clone <URL_DEL_REPOSITORIO> ~/.config/nvim

    # En Windows (PowerShell)
    git clone <URL_DEL_REPOSITORIO> $env:LOCALAPPDATA\nvim
    ```

3.  **Inicia NeoVim:**
    Abre NeoVim en tu terminal:
    ```bash
    nvim
    ```
    La primera vez que lo inicies, `lazy.nvim` se instalará automáticamente y luego descargará y configurará todos los plugins definidos en `plugins.lua`. Este proceso puede tardar unos minutos.

4.  **Verifica la instalación:**
    Una vez que `lazy.nvim` termine, reinicia NeoVim. Deberías ver la nueva interfaz de usuario.

    Para verificar que los servidores de lenguaje se han instalado, ejecuta el siguiente comando dentro de NeoVim:
    ```
    :Mason
    ```
    Asegúrate de que `jdtls` y `lua-ls` estén en la lista de paquetes instalados.

---

## 3. Uso del Depurador (DAP) para Java

El depurador se integra con el LSP para ofrecer una experiencia fluida. Para depurar, necesitas crear una configuración de lanzamiento.

### Creación de `launch.json`

El depurador de Java utiliza la misma configuración `launch.json` que VS Code.

1.  Abre la paleta de comandos del depurador con `<leader>d` (por ejemplo, `Espacio + d`).
2.  Para proyectos Maven, la forma más fácil de empezar a depurar es usando las *Code Actions* del LSP. `nvim-jdtls` proporciona acciones para depurar tests o métodos `main`.

### Ejemplo: Depurar una aplicación Maven

1.  Abre el archivo Java que contiene tu método `main`.
2.  Coloca el cursor sobre el método `main`.
3.  Ejecuta la acción de código con `<leader>ca`.
4.  Selecciona la opción "Debug..." en el menú emergente.
5.  El depurador se iniciará y la interfaz de `nvim-dap-ui` aparecerá.

### Ejemplo: Depurar un servidor JBoss/WildFly remoto

Si tu aplicación se despliega en un servidor de aplicaciones como JBoss/WildFly, puedes conectarte a él de forma remota.

1.  **Inicia JBoss/WildFly en modo de depuración.**
    Normalmente, esto se hace añadiendo los siguientes argumentos a la JVM al iniciar el servidor:
    ```bash
    -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000
    ```
    Esto le dice a la JVM que escuche conexiones de depuración en el puerto 8000.

2.  **Crea un archivo `.vscode/launch.json` en la raíz de tu proyecto** con la siguiente configuración:
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Attach to JBoss/WildFly",
          "request": "attach",
          "hostName": "localhost", // o la IP del servidor
          "port": 8000,
          "projectName": "nombre-del-proyecto-maven" // Opcional pero recomendado
        }
      ]
    }
    ```

3.  **Inicia la sesión de depuración en NeoVim:**
    - Abre NeoVim en la raíz de tu proyecto.
    - Presiona `<F5>` (o la tecla que configures para iniciar el depurador).
    - Selecciona "Attach to JBoss/WildFly" en el menú que aparece.
    - El depurador se conectará al servidor. Ahora puedes poner breakpoints en tu código y se detendrán cuando el servidor los alcance.
