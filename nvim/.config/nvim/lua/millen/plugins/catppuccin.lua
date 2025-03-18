return { 
    "catppuccin/nvim", 

    tag = "v1.9.0",
    name = "catppuccin",
    priority = 1000,

    config = function()
        require('catppuccin').setup({
            flavour = "macchiato",
            integrations = {
                telescope = {
                    enabled = true,
                },
            },
        });

        vim.cmd.colorscheme "catppuccin";
    end
}
