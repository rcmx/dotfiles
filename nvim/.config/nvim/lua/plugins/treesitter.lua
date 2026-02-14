return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")

            ts.setup({})

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        lazy = false,
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                },
                move = {
                    set_jumps = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            vim.keymap.set({ "x", "o" }, "af", function()
                select.select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                select.select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                select.select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                select.select_textobject("@class.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ap", function()
                select.select_textobject("@parameter.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ip", function()
                select.select_textobject("@parameter.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ab", function()
                select.select_textobject("@block.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ib", function()
                select.select_textobject("@block.inner", "textobjects")
            end)

            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                move.goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                move.goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                move.goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                move.goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                move.goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                move.goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                move.goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                move.goto_previous_end("@class.outer", "textobjects")
            end)

            vim.keymap.set("n", "<leader>a", function()
                swap.swap_next("@parameter.inner", "textobjects")
            end)
            vim.keymap.set("n", "<leader>A", function()
                swap.swap_previous("@parameter.inner", "textobjects")
            end)
        end,
    },
}
