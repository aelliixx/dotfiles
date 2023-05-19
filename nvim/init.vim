call plug#begin()  
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terryma/vim-multiple-cursors'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'sbdchd/neoformat'
Plug 'preservim/nerdcommenter'
Plug 'sindrets/diffview.nvim'
Plug 'dense-analysis/ale'
Plug 'ilyachur/cmake4vim'
call plug#end()


" Coc autocomplete

inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <silent><expr> <cr>  pumvisible() ? coc#_select_confirm() : "\<c-g>u\<cr>"
" inoremap <silent><expr> <Esc> pumvisible() ? <Esc> : <Esc>


" Telescope

noremap <C-p> <cmd>Telescope find_files<cr>
noremap <C-f> <cmd>Telescope live_grep<cr>
noremap <A-b>fb <cmd>Telescope buffers<cr>
noremap <A-h> <cmd>Telescope help_tags<cr>
noremap <C-b> <cmd>NvimTreeToggle<cr> 

" Saving

nnoremap <silent> <C-s> :w<CR>
nnoremap <silent> <C-s>q :wq<CR>
inoremap <silent> <C-s> <Esc>:w<CR>i<Right>
inoremap <silent> <C-s>q <Esc>:wq<CR>

" Switching windows

nnoremap <silent> <C-S-Up> :wincmd k<CR>
nnoremap <silent> <C-S-Down> :wincmd j<CR>
nnoremap <silent> <C-S-Left> :wincmd h<CR>
nnoremap <silent> <C-S-Right> :wincmd l<CR>
inoremap <silent> <C-S-Up> <Esc> <C-S-Up> :wincmd k<CR>
inoremap <silent> <C-S-Down> <Esc><C-S-Down> :wincmd j<CR>
inoremap <silent> <C-S-Left> <Esc><C-S-Left> :wincmd h<CR>
inoremap <silent> <C-S-Right> <Esc><C-S-Right> :wincmd l<CR>



" Move lines up or down

nnoremap <silent><S-Down> :m .+1<CR>==
nnoremap <silent><S-Up> :m .-2<CR>==
inoremap <silent><S-Up> <Esc>:m .-2<CR>==gi
inoremap <silent><S-Down> <Esc>:m .+1<CR>==gi
vnoremap <silent><S-Up> :m '<-2<CR>gv=gv
vnoremap <silent><S-Down> :m '>+1<CR>gv=gv

" Delete lines

nnoremap <silent><S-Delete> dd
vnoremap <silent><S-Delete> <Delete>
inoremap <silent><S-Delete> <Esc>ddi


" Formatting

vnoremap <silent><A-S-F> :Neoformat<cr>
nnoremap <silent><A-S-F> :Neoformat<cr>
inoremap <silent><A-S-F> <Esc>:Neoformat<cr>i

" Commenting

nnoremap <silent> <C-_> V:call nerdcommenter#Comment('x', 'toggle')<CR>
vnoremap <silent> <C-_> V:call nerdcommenter#Comment('x', 'toggle')<CR>

" Resizing panes

nnoremap <silent> = :res +1<CR>
nnoremap <silent> - :res -1<CR>
nnoremap <silent> + :vertical resize +1<CR>
nnoremap <silent> _  :vertical resize -1<CR>

" Cmake copile commands (https://stackoverflow.com/questions/69708154/setting-up-neovim-for-c-with-cmake)

nnoremap <F5> :wa <bar> :set makeprg=cd\ build\ &&\ cmake\ -DCMAKE_BUILD_TYPE=debug\ -DCMAKE_EXPORT_COMPILE_COMMANDS=1\ ../\ &&\ cmake\ --build\ . <bar> :compiler gcc <bar> :make <CR>



set tabstop=4

set shiftwidth=4

set number

colorscheme nightfox

filetype plugin on



lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 -- globally enable different highlight colors per icon (default to true)
 -- if set to false all icons will have the default icon's color
 color_icons = true;
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
 -- globally enable "strict" selection of icons - icon will be looked up in
 -- different tables, first by filename, and if not found by extension; this
 -- prevents cases when file doesn't have any extension but still gets some icon
 -- because its name happened to match some extension (default to false)
 strict = true;
 -- same as `override` but specifically for overrides by filename
 -- takes effect when `strict` is true
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 -- same as `override` but specifically for overrides by extension
 -- takes effect when `strict` is true
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}
EOF

lua << END
require('lualine').setup()
END

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua << EOF
	-- examples for your init.lua

    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    
	require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      sort_by = "name",
      root_dirs = {},
      prefer_startup_root = true,
      sync_root_with_cwd = true,
      reload_on_bufenter = true,
      respect_buf_cwd = true,
      on_attach = "default",
      remove_keymaps = false,
      select_prompts = false,
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
          },
        },
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "all",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
        },
      },
      experimental = {
        git = {
          async = false,
        },
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    }
EOF


