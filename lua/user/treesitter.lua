require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    ensure_installed = {'python', 'typescript', 'yaml', 'vim', 'scss', 'ruby', 'regex', 'php', 'make', 'json', 'javascript', 'http', 'html', 'help', 'graphql', 'dockerfile', 'css'},
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
    indent = { enable = true },
}
