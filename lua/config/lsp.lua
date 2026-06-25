local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_capabilities = pcall(require, "cmp_nvim_lsp")
if ok then
    capabilities = cmp_capabilities.default_capabilities()
end

local on_attach = function(_, bufnr)
    local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gr", vim.lsp.buf.references, "References")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>k", vim.lsp.buf.signature_help, "Signature help")
    map("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, "Format")
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
end

local servers = {
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
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_enable = false,
})

for _, server in ipairs(servers) do
    local ok, server_config = pcall(require, "lspconfig.configs." .. server)
    if ok then
        local config = vim.tbl_deep_extend("keep", {}, server_config.default_config)
        if type(config.root_dir) == "function" then
            local old_root_dir = config.root_dir
            config.root_dir = function(bufnr, callback)
                local fname = vim.api.nvim_buf_get_name(bufnr)
                if fname and #fname > 0 then
                    callback(old_root_dir(fname, bufnr))
                else
                    callback(nil)
                end
            end
        end
        config.capabilities = capabilities
        config.on_attach = on_attach
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
    else
        vim.notify("Failed to load LSP config for: " .. server, vim.log.levels.WARN)
    end
end
