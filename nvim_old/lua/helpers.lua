-- Telescope file browser
local function open_file_browser()
    local telescope = require("telescope")
    local function telescope_buffer_dir()
        return vim.fn.expand("%:p:h")
    end

    local w = vim.api.nvim_win_get_width(0)
    local h = vim.api.nvim_win_get_height(0)

    telescope.extensions.file_browser.file_browser({
        path = "%:p:h",
        cmd = telescope_buffer_dir(),
        respect_gitignore = false,
        hidden = false,
        grouped = true,
        previewer = true,
        initial_mode = "normal",

        prompt_title = vim.fn.getcwd(),
        theme = "dropdown",
        layout_config = { height = h, width = w, prompt_position = "top" },
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        selection_caret = "  ",
        borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
        file_icons = true,
        dir_icon = "󰉋"

    })
end

vim.api.nvim_create_user_command("MLOpenFileBrowser", open_file_browser, {});
