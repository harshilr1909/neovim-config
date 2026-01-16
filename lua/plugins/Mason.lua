return {
    "mason-org/mason.nvim",
    
opts = {
        ensure_installed = { "lua_ls", "rust_analyzer","tsserver" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
