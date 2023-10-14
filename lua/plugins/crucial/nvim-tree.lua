local icons = require "utils.icons"
return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle" },
  keys = {
    { "<leader>fe", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  },
  opts = {
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
    view = {
      number = true,
      relativenumber = true,
    },
    filters = {
      custom = { "node_modules" },
    },
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
    renderer = {
      highlight_git = true,
      highlight_opened_files = "none",

      root_folder_label = function(path)
        local project = vim.fn.fnamemodify(path, ":t")
        return icons.ui.Home .. string.upper(project)
      end,

      indent_markers = {
        enable = true,
      },

      icons = {
        webdev_colors = true,
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
        glyphs = {
          default = icons.ui.File,
          symlink = icons.ui.FileSymlink,
          folder = {
            default = icons.ui.Folder,
            empty = icons.ui.EmptyFolder,
            empty_open = icons.ui.EmptyFolderOpen,
            open = icons.ui.FolderOpen,
            symlink = icons.ui.FolderSymlink,
            symlink_open = icons.ui.FolderSymlink,
            arrow_open = icons.ui.TriangleShortArrowDown,
            arrow_closed = icons.ui.TriangleShortArrowRight,
          },
          git = {
            staged = icons.git.FileStaged,
            deleted = icons.git.FileDeleted,
            renamed = icons.git.FileRenamed,
            unstaged = icons.git.FileUnstaged,
            unmerged = icons.git.FileUnmerged,
            untracked = icons.git.FileUntracked,
            ignored = icons.git.FileIgnored,
          },
        },
      },
    },
  },
}
