# Tabla de Atajos de Teclado (Keybindings)

Esta tabla resume los atajos de teclado más importantes de esta configuración de NeoVim, organizados por funcionalidad para facilitar la transición desde IntelliJ IDEA.

**Nota:** La tecla `<leader>` está mapeada a la barra espaciadora (`Space`).

---

## Navegación y Gestión de Ventanas

| Atajo               | Acción                                         | Equivalente en IntelliJ (Aproximado) |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `<leader>e`         | Abrir/Cerrar el explorador de archivos (`neo-tree`) | `Alt + 1` (Project View)              |
| `<Tab>`             | Ir a la pestaña/buffer siguiente                | `Alt + Right Arrow`                   |
| `<S-Tab>`           | Ir a la pestaña/buffer anterior                 | `Alt + Left Arrow`                    |
| `<leader>bc`         | Cerrar la pestaña/buffer actual                 | `Ctrl + F4`                           |
| `<C-h/j/k/l>`       | Moverse entre ventanas (splits)                | Moverse con el ratón entre splits     |

---

## Búsqueda (Telescope)

| Atajo               | Acción                                         | Equivalente en IntelliJ (Aproximado) |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `<leader>ff`         | Buscar archivos en el proyecto (`Find Files`)  | `Shift + Shift` (Search Everywhere)   |
| `<leader>fg`         | Buscar texto en todo el proyecto (`Live Grep`) | `Ctrl + Shift + F` (Find in Files)    |

---

## LSP (Funcionalidades de Código)

| Atajo               | Acción                                         | Equivalente en IntelliJ (Aproximado) |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `gd`                | Ir a la definición (`Go to Definition`)        | `Ctrl + Click` o `Ctrl + B`           |
| `gr`                | Encontrar referencias (`Find References`)       | `Alt + F7`                            |
| `K`                 | Mostrar documentación (`Hover`)                | `Ctrl + Q`                            |
| `<leader>rn`         | Renombrar símbolo (`Rename`)                   | `Shift + F6`                          |
| `<leader>ca`         | Ver acciones de código (`Code Actions`)        | `Alt + Enter`                         |
| `[d` / `]d`          | Ir al diagnóstico anterior/siguiente           | `F2` / `Shift + F2`                   |
| `<leader>f`         | Formatear el código del buffer actual          | `Ctrl + Alt + L`                      |

---

## Depurador (DAP)

| Atajo               | Acción                                         | Equivalente en IntelliJ (Aproximado) |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `<leader>db`         | Poner/Quitar punto de ruptura (`Breakpoint`)   | `Ctrl + F8`                           |
| `<leader>dc`         | Continuar la ejecución                         | `F9` (Resume Program)                 |
| `<leader>do`         | Pasar por encima (`Step Over`)                 | `F8`                                  |
| `<leader>di`         | Entrar en la función (`Step Into`)             | `F7`                                  |
| `<leader>dO`         | Salir de la función (`Step Out`)               | `Shift + F8`                          |
| `<leader>du`         | Abrir/Cerrar la interfaz del depurador         | Pestaña "Debugger" (`Alt + 5`)        |

---

## Edición y Miscelánea

| Atajo               | Acción                                         | Equivalente en IntelliJ (Aproximado) |
| ------------------- | ---------------------------------------------- | ------------------------------------- |
| `<C-s>`             | Guardar el archivo                             | `Ctrl + S`                            |
| `J` / `K` (Visual)  | Mover línea/bloque seleccionado arriba/abajo   | `Ctrl + Shift + Up/Down`              |
