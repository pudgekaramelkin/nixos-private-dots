-- [[ Базовые настройки. Не плагины ]]
require 'kickstart.settings'
require 'custom.terminal'
require 'custom.sessions'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
-- git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({

    ---------------------------------------------
    -- Установлены из коробки в kickstart.nvim --
    ---------------------------------------------

    -- Git integration for buffers
    require 'kickstart.plugins.gitsigns',

    -- Useful plugin to show you pending keybinds.
    require 'kickstart.plugins.which-key',

    -- Fuzzy Finder (files, lsp, etc)
    require 'kickstart.plugins.telescope',

    -- LSP Plugins
    require 'kickstart.plugins.lsp',

    -- Autoformat
    require 'kickstart.plugins.autoformat',

    -- Autocompletion
    require 'kickstart.plugins.completion',

    -- Themes
    require 'kickstart.plugins.themes',

    -- Highlight todo, notes, etc in comments
    require 'kickstart.plugins.todo-comments',

    -- Collection of various small independent plugins/modules
    require 'kickstart.plugins.mini',

    -- Highlight, edit, and navigate code
    require 'kickstart.plugins.treesitter',

    -- Debug your code via Debug Adapter Protocol
    require 'kickstart.plugins.debug',

    -- Add indentation guides even on blank lines
    require 'kickstart.plugins.indent_line',

    -- Linting
    require 'kickstart.plugins.lint',

    -- Autopairs
    require 'kickstart.plugins.autopairs',

    -- Browse the file system
    require 'kickstart.plugins.file-tree',

    -------------------------------------
    -- Установил руками под свои нужды --
    -------------------------------------

    -- Supercharge your Rust experience in Neovim
    require 'custom.plugins.rust',

    -- Feature-Rich Go Plugin for Neovim
    require 'custom.plugins.golang',

    -- Plugins for git
    require 'custom.plugins.git',

    -- Plugins for color highlight
    require 'custom.plugins.colorizer',

    -- Symbol usage plugin
    require 'custom.plugins.symbol_usage',

    -- Adding history for nvim clipboard
    require 'custom.plugins.clip_history',

    -- Autoformat markdown tables
    {
        'Kicamon/markdown-table-mode.nvim',
        config = function()
            require('markdown-table-mode').setup {
                filetype = {
                    '*.md',
                },
                options = {
                    insert = true, -- when typing "|"
                    insert_leave = true, -- when leaving insert
                    pad_separator_line = false, -- add space in separator line
                    alig_style = 'default', -- default, left, center, right
                },
            }
        end,
    },

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    -- { import = 'custom.plugins' },
    --
    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
