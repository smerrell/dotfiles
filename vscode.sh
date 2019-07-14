#!/usr/bin/env bash

vscodeInstance="code"
if [ "$1" == "--insiders" ]; then
    vscodeInstance="code-insiders"
fi

# test code is installed
command -v $vscodeInstance >/dev/null 2>&1 || {
    echo >&2 "This script requires $vscodeInstance but it's not installed. Aborting."
    exit 1;
}

# Test if macOS
platform=$(uname)

# Test if Windows
if [[ "$platform" = MINGW* || "$platform" = CYGWIN* ]]; then
    codeSettingsDir="$APPDATA/Code/User"

    if [ "$vscodeInstance" == "code-insiders" ]; then
        codeSettingsDir="$APPDATA/Code - Insiders/User"
        params="-Insiders"
    fi

    echo "Configuring VS Code on Windows"

    # Call powershell to symlink
    powershell ./vscode.ps1 $params
fi


if [ "$platform" == "Darwin" ]; then
    codeSettingsDir="$HOME/Library/Application Support/Code/User"

    if [ "$vscodeInstance" == "code-insiders" ]; then
        codeSettingsDir="$HOME/Library/Application Support/Code - Insiders/User"
    fi

    ln -sfv "$PWD/vscode/settings.json" "$codeSettingsDir/settings.json"
fi

extensions=(
    "EditorConfig.editorconfig"
    "Tyriar.sort-lines"
    "davidanson.vscode-markdownlint"
    "dracula-theme.theme-dracula"
    "mauve.terraform"
    "ms-vscode.csharp"
    "stkb.rewrap"
    "vscodevim.vim"
    #"JPTarquino.postgresql"
    #"Stephanvs.dot"
    #"VisualStudioOnlineApplicationInsights.application-insights"
    #"bungcip.better-toml"
    #"cake-build.cake-vscode"
    #"esbenp.prettier-vscode"
    #"jebbs.plantuml"
    #"ms-azuretools.vscode-azurefunctions"
    #"ms-mssql.mssql"
    #"ms-vscode.azure-account"
    #"ms-vscode.mono-debug"
    #"ms-vscode.powershell"
    #"msazurermtools.azurerm-vscode-tools"
    #"qhoekman.language-plantuml"
    #"rust-lang.rust"
    #"streetsidesoftware.code-spell-checker"
    #"vadimcn.vscode-lldb"
    #"webfreak.debug"
)

for extension in ${extensions[@]}; do
    $vscodeInstance --install-extension $extension
done

