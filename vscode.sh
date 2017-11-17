#!/usr/bin/env bash

plugins=(
    "EditorConfig.editorconfig"
    "JPTarquino.postgresql"
    "Stephanvs.dot"
    "Tyriar.sort-lines"
    "bungcip.better-toml"
    "cake-build.cake-vscode"
    "dracula-theme.theme-dracula"
    "esbenp.prettier-vscode"
    "jebbs.plantuml"
    "ms-mssql.mssql"
    "ms-vscode.csharp"
    "ms-vscode.mono-debug"
    "ms-vscode.powershell"
    "qhoekman.language-plantuml"
    "rust-lang.rust"
    "stkb.rewrap"
    "vadimcn.vscode-lldb"
    "vscodevim.vim"
    "webfreak.debug"
)

for plugin in ${plugins[@]}; do
    code --install-extension $plugin
done

