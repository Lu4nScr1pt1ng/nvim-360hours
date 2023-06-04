return {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = {},
        section_separators = {},
        disabled_filetypes = {
              statusline = { "luan", "lazy", "netrw" },
          winbar = {
            "netrw",
            "help",
            "luan",
            "lazy",
          },
        },
        always_divide_middle = true,
        globalstatus = true,
      },
      extensions = {  'chadtree', "nvim-tree", "toggleterm", "quickfix" },
    }
  end
}
