# Configuración de NeoVim para Desarrollo Java Empresarial (Estilo IntelliJ)

Esta es una configuración completa y moderna de NeoVim diseñada para ser un reemplazo ligero, rápido y productivo de IntelliJ IDEA para el desarrollo de aplicaciones Java empresariales.

## Características Principales

- **Gestor de Plugins Ligero:** Usa [lazy.nvim](https://github.com/folke/lazy.nvim) para una carga perezosa y un arranque casi instantáneo.
- **Interfaz de Usuario similar a IntelliJ:**
    - Tema oscuro profesional ([tokyonight.nvim](https://github.com/folke/tokyonight.nvim)).
    - Explorador de archivos con iconos ([neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)).
    - Barra de estado informativa ([lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)).
    - Pestañas en la parte superior ([bufferline.nvim](https://github.com/akinsho/bufferline.nvim)).
- **Soporte Completo para Java:**
    - **LSP:** Integración total con `jdtls` para autocompletado, diagnósticos y refactorización.
    - **DAP:** Depurador visual integrado para Java a través de [nvim-dap](https://github.com/mfussenegger/nvim-dap).
- **Herramientas de Productividad:**
    - Búsqueda difusa con [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim).
    - Integración con Git a través de [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) y [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim).
    - Asistencia de IA con [Copilot](https://github.com/github/copilot.vim).

---

## 1. Requisitos Previos

- **NeoVim (v0.8.0 o superior)**
- **Java JDK (v17 o superior):** `jdtls` (el servidor de lenguaje) necesita un JDK moderno para funcionar, aunque puedes seguir desarrollando en proyectos con Java 8/11.
- **Maven**
- **Git**
- **Nerd Fonts:** Necesarias para que los iconos se muestren correctamente. Descarga una desde [Nerd Fonts](https://www.nerdfonts.com/font-downloads).
- **Herramientas de compilación:** `gcc`, `make`, `unzip`.
- **(Opcional) Lazygit:** Para usar la interfaz de Git. Sigue las instrucciones de instalación en su [repositorio](https://github.com/jesseduffield/lazygit).

---

## 2. Instalación

1.  **Haz una copia de seguridad de tu configuración actual:**
    ```bash
    # Linux/macOS
    mv ~/.config/nvim ~/.config/nvim.bak
    # Windows (PowerShell)
    Move-Item -Path $env:LOCALAPPDATA\nvim -Destination $env:LOCALAPPDATA\nvim.bak
    ```

2.  **Clona este repositorio en tu directorio de configuración:**
    ```bash
    # Reemplaza <URL_DEL_REPOSITORIO> con la URL de este proyecto.
    git clone <URL_DEL_REPOSITORIO> ~/.config/nvim
    ```

3.  **Inicia NeoVim:**
    ```bash
    nvim
    ```
    La primera vez, `lazy.nvim` se instalará y descargará todos los plugins. Este proceso puede tardar unos minutos. Una vez terminado, reinicia NeoVim.

4.  **Verifica la instalación de los LSPs:**
    Ejecuta `:Mason` dentro de NeoVim y asegúrate de que `jdtls` y `lua-ls` estén instalados.

---

## 3. Atajos de Teclado Principales

La tecla "Líder" está mapeada a la **barra espaciadora**.

| Atajo                 | Acción                                         |
| --------------------- | ---------------------------------------------- |
| **Navegación**        |                                                |
| `<Leader>e`           | Abrir/Cerrar el explorador de archivos         |
| `<Tab>` / `<S-Tab>`   | Moverse entre pestañas (buffers)               |
| `<C-h/j/k/l>`         | Moverse entre ventanas divididas               |
| **Búsqueda**          |                                                |
| `<Leader>ff`          | Buscar archivos en el proyecto                 |
| `<Leader>fg`          | Buscar texto en el proyecto                    |
| **Git**               |                                                |
| `<Leader>lg`          | Abrir la interfaz de Lazygit                   |
| **LSP (Código)**      |                                                |
| `gd`                  | Ir a la definición                             |
| `K`                   | Mostrar documentación (al pasar el cursor)     |
| `gr`                  | Mostrar referencias del símbolo                 |
| `<Leader>ca`          | Ver acciones de código disponibles (refactor, etc.) |
| `<Leader>rn`          | Renombrar símbolo                              |
| **Depurador (DAP)**   |                                                |
| `<Leader>db`          | Poner/Quitar un punto de interrupción (breakpoint) |
| `<Leader>dc`          | Iniciar o continuar la ejecución               |
| `<Leader>di` / `<leader>do` | Entrar (Step In) / Salir (Step Out) de una función |
| `<Leader>du`          | Abrir/Cerrar la interfaz del depurador         |

---

## 4. Uso del Depurador (Java)

1.  **Pon un punto de interrupción:** Ve a la línea donde quieres que se detenga la ejecución y presiona `<Leader>db`.
2.  **Inicia la depuración:** Coloca el cursor sobre un método `main` o un test de JUnit.
3.  Presiona `<Leader>ca` para abrir las acciones de código y selecciona la opción "Debug...".
4.  La ejecución se detendrá en tu punto de interrupción y la interfaz del depurador aparecerá, permitiéndote inspeccionar variables y controlar el flujo.

### Depuración Remota (JBoss/WildFly)

Puedes conectarte a un servidor remoto que se esté ejecutando en modo de depuración.

1.  **Inicia tu servidor JBoss/WildFly en modo de depuración** (normalmente con flags como `-agentlib:jdwp=...`).
2.  **Crea un archivo `.vscode/launch.json`** en la raíz de tu proyecto con una configuración de tipo "attach":
    ```json
    {
      "version": "0.2.0",
      "configurations": [
        {
          "type": "java",
          "name": "Attach to JBoss",
          "request": "attach",
          "hostName": "localhost",
          "port": 8000
        }
      ]
    }
    ```
3.  En NeoVim, presiona `<Leader>dc` y selecciona la configuración "Attach to JBoss". El depurador se conectará al servidor.
