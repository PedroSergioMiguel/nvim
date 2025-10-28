-- Opciones generales de Neovim para una experiencia similar a un IDE

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Establecer el número de línea
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentación
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Búsqueda
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Apariencia
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false

-- Comportamiento
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus" -- Sincronización con el portapapeles del sistema
vim.opt.swapfile = false
vim.opt.backup = false
-- Configuración de directorio de 'undo' compatible con Windows/Linux/macOS
local undodir_path = os.getenv("HOME")
if undodir_path == nil then
  undodir_path = os.getenv("USERPROFILE")
end
vim.opt.undodir = undodir_path .. "/.vim/undodir"
vim.opt.undofile = true

-- Completado
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Tiempos de espera
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

print("Opciones de Neovim cargadas.")
