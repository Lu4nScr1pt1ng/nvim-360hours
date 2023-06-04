-- NOTE: vim.fn.stdpath("data") is in Linux systems: ~/.local/nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- If it's not found - indicating that it's not found - Git clone it.
if not vim.loop.fs_stat(lazypath) then
  -- Show a lovely message indicating that we're boostrapping lazy :)
  print(" Bootstrapping lazy.nvim!")

  -- NOTE: lazy.nvim recommends to use vim.fn.system but, via `vim.cmd("!...")` we can know the progress 🤯
  vim.cmd("!git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)

  -- TODO: Try to make this actually show up. (it's destroyed by cmdheight atm)
  print(" Done!")
end

-- Add it to RTP. So, we can require it later on.
vim.opt.rtp:prepend(lazypath)

-- NOTE: import plugins from `lua/plugins/specs`
require("lazy").setup({ import = "plugins.crucial" }, {
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    missing = true
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
          "gzip",
        "logipat",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})


vim.keymap.set("n", "<leader>zz", "<cmd>:Lazy<cr>", { desc = "Manage Plugins" })
