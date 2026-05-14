local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_capabilities = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_capabilities.default_capabilities()
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
        "emmet_language_server",
        "jdtls",
        "html",
        "pyright",
        "sqlls",
        "clangd",
        "gopls",
    },
    automatic_installation = true,
    handlers = {
        function(server_name)
            lspconfig[server_name].setup({ capabilities = capabilities })
        end,
    },
})
