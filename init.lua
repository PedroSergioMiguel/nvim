-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Cargar configuración modular
require("pedrosergiomiguel.core.options")
require("pedrosergiomiguel.core.keymaps")

-- Cargar plugins con lazy.nvim
require("lazy").setup("pedrosergiomiguel.plugins")
