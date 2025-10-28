# Tabla de Atajos de Teclado (Keybindings)

Esta tabla resume los atajos de teclado clave configurados en este entorno de NeoVim, diseñados para emular la productividad de IntelliJ IDEA.

**Leader Key:** La tecla `Líder` está mapeada a `Espacio`. Presiona `Espacio` seguido de la secuencia de teclas indicada.

## Atajos Generales y de UI

| Atajo             | Acción                               |
| ----------------- | ------------------------------------ |
| `<leader>e`       | Abrir/Cerrar el explorador de archivos (Neo-tree) |

## Telescope (Buscador Fuzzy)

| Atajo             | Acción                               |
| ----------------- | ------------------------------------ |
| `<leader>ff`      | Buscar archivos en el proyecto       |
| `<leader>fg`      | Buscar texto en todo el proyecto (Live Grep) |
| `<leader>fb`      | Buscar buffers abiertos              |
| `<leader>fh`      | Buscar tags de ayuda                 |

## LSP (Navegación de Código y Refactorización)

| Atajo             | Acción                               |
| ----------------- | ------------------------------------ |
| `gd`              | Ir a la definición                   |
| `gD`              | Ir a la declaración                  |
| `gi`              | Ir a la implementación               |
| `gr`              | Encontrar referencias                 |
| `K`               | Mostrar documentación al pasar el cursor (Hover) |
| `<leader>rn`      | Renombrar símbolo                    |
| `<leader>ca`      | Ver y ejecutar acciones de código (Code Actions) |
| `[d`              | Ir al diagnóstico anterior           |
| `]d`              | Ir al siguiente diagnóstico          |
| `<leader>e`       | Mostrar detalles del diagnóstico en ventana flotante |

## Debugger (DAP)

| Atajo             | Acción                               |
| ----------------- | ------------------------------------ |
| `<leader>db`      | Poner/Quitar punto de interrupción (Breakpoint) |
| `<leader>dc`      | Continuar ejecución                  |
| `<leader>di`      | Entrar en el método (Step Into)      |
| `<leader>do`      | Pasar por encima del método (Step Over) |
| `<leader>dO`      | Salir del método (Step Out)          |
| `<leader>dr`      | Abrir la consola REPL                |
| `<leader>dl`      | Ejecutar la última sesión de depuración |
