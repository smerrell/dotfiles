#!/usr/bin/env bash

vscodeInstance="code"
if [ "$1" == "--insiders" ]; then
    vscodeInstance="code-insiders"
fi

extensions=(
    "EditorConfig.editorconfig"
    "JPTarquino.postgresql"
    "Stephanvs.dot"
    "Tyriar.sort-lines"
    "VisualStudioOnlineApplicationInsights.application-insights"
    "bungcip.better-toml"
    "cake-build.cake-vscode"
    "dracula-theme.theme-dracula"
    "esbenp.prettier-vscode"
    "jebbs.plantuml"
    "ms-azuretools.vscode-azurefunctions"
    "ms-mssql.mssql"
    "ms-vscode.azure-account"
    "ms-vscode.csharp"
    "ms-vscode.mono-debug"
    "ms-vscode.powershell"
    "msazurermtools.azurerm-vscode-tools"
    "qhoekman.language-plantuml"
    "rust-lang.rust"
    "stkb.rewrap"
    "streetsidesoftware.code-spell-checker"
    "vadimcn.vscode-lldb"
    "vscodevim.vim"
    "webfreak.debug"
)

for extension in ${extensions[@]}; do
    $vscodeInstance --install-extension $extension
done

