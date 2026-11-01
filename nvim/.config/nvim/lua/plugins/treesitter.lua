return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")

            ts.setup({})

            ts.install({
                "c_sharp",
                "dockerfile",
                "editorconfig",
                "html",
                "javascript",
                "json",
                "json5",
                "lua",
                "markdown",
                "markdown_inline",
                "powershell",
                "svelte",
                "typescript",
                "vim",
                "xml",
                "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    -- only take over indenting when a parser actually attached,
                    -- otherwise keep the filetype's own indent rules
                    if pcall(vim.treesitter.start, args.buf) then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
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
                select = { lookahead = true },
                move = { set_jumps = true },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            -- select: a = around, i = inside
            local objects = {
                f = { "function", "Function" },
                c = { "class", "Class" },
                p = { "parameter", "Parameter" },
                b = { "block", "Block" },
            }
            for key, obj in pairs(objects) do
                local capture, name = obj[1], obj[2]
                vim.keymap.set({ "x", "o" }, "a" .. key, function()
                    select.select_textobject("@" .. capture .. ".outer", "textobjects")
                end, { desc = "Around " .. name })
                vim.keymap.set({ "x", "o" }, "i" .. key, function()
                    select.select_textobject("@" .. capture .. ".inner", "textobjects")
                end, { desc = "Inside " .. name })
            end

            -- move; function starts also re-center the screen (normal mode only)
            local function map_move(lhs, fn, capture, desc, center)
                vim.keymap.set({ "n", "x", "o" }, lhs, function()
                    fn(capture, "textobjects")
                    if center and vim.fn.mode() == "n" then
                        vim.cmd("normal! zz")
                    end
                end, { desc = desc })
            end
            map_move("]m", move.goto_next_start, "@function.outer", "Next Function Start", true)
            map_move("[m", move.goto_previous_start, "@function.outer", "Previous Function Start", true)
            map_move("]M", move.goto_next_end, "@function.outer", "Next Function End")
            map_move("[M", move.goto_previous_end, "@function.outer", "Previous Function End")
            map_move("]]", move.goto_next_start, "@class.outer", "Next Class Start")
            map_move("[[", move.goto_previous_start, "@class.outer", "Previous Class Start")
            map_move("][", move.goto_next_end, "@class.outer", "Next Class End")
            map_move("[]", move.goto_previous_end, "@class.outer", "Previous Class End")

            vim.keymap.set("n", "<leader>a", function()
                swap.swap_next("@parameter.inner", "textobjects")
            end, { desc = "Swap With Next Parameter" })
            vim.keymap.set("n", "<leader>A", function()
                swap.swap_previous("@parameter.inner", "textobjects")
            end, { desc = "Swap With Previous Parameter" })
        end,
    },
}
