return {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function () 
        local fzf = require("fzf-lua")
        fzf.setup({"default"})

        vim.keymap.set("n", "<Leader>ff", fzf.files, {})

        vim.keymap.set("n", "<Leader>ffh", function()
            fzf.files({
                hidden = true,
                git_icons = true,
                fd_opts = "--color=never --type f --hidden --exclude .git"
            })
        end, {})

        vim.keymap.set("n", "<Leader>fb", fzf.buffers, {})

        vim.keymap.set("n", "<Leader>fg", fzf.live_grep, {})

        vim.keymap.set("n", "<Leader>fgh", function()
            fzf.live_grep({
                rg_opts = "--hidden --glob=!.git/ --column --line-number --no-heading --color=always --smart-case"
            })
        end, {})

        vim.keymap.set("n", "<Leader>km", fzf.keymaps, {})

        -- fzf.register_ui_select()
    end
}

