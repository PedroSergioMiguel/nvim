-- Atajos de teclado para una mejor experiencia

local map = vim.keymap.set

-- Modo Normal
-- Movimiento entre ventanas
map("n", "<C-h>", "<C-w>h", { desc = "Mover a la ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Mover a la ventana inferior" })
map("n", "<C-k>", "<C-w>k", { desc = "Mover a la ventana superior" })
map("n", "<C-l>", "<C-w>l", { desc = "Mover a la ventana derecha" })

-- Redimensionar ventanas
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Aumentar altura de la ventana" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Disminuir altura de la ventana" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Disminuir ancho de la ventana" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Aumentar ancho de la ventana" })

-- Pestañas/Buffers
map("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Cerrar buffer actual" })

-- Guardar
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Guardar archivo" })

-- Modo Inserción
-- Movimiento rápido
map("i", "jk", "<ESC>", { desc = "Salir del modo inserción" })

-- Modo Visual
-- Mover líneas seleccionadas
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover línea hacia abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover línea hacia arriba" })


print("Atajos de teclado cargados.")
