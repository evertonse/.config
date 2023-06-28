local ui = {}
local highlights = require "custom.user.highlights"
ui = {
    theme = 'nightlamp',
    lsp_semantic_tokens = true,
    nvdash = {
        load_on_startup = true,
        header_backup = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        },

        header = {

          [[ ██████╗██╗   ██╗██████╗ ███████╗██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
          [[██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██║   ██║██║████╗ ████║ ]],
          [[██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██║   ██║██║██╔████╔██║ ]],
          [[██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
          [[╚██████╗   ██║   ██████╔╝███████╗██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
          [[ ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        }
    },
    transparency = true,
    hl_override = highlights.override,
    hl_add = highlights.add,
}

return ui
