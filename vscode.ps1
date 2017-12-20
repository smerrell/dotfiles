Param(
    [switch] $insiders
)

$codePath = "$env:APPDATA\Code\User"

if ($insiders) {
    # Spaces in a path, couldn't figure out how to do single quote
    # escaping the right way. Tried the "' thing but no luck
    $codePath = "$env:APPDATA\Code - Insiders\User".Replace(" ", "` ")
}

$settingsPath = Join-Path $codePath "settings.json"
$settingIsSymlink = (Get-Item -ErrorAction SilentlyContinue $settingsPath).LinkType `
    -eq "SymbolicLink"

if ((Test-Path $settingsPath) -and (-not $settingIsSymlink)) {
    Write-Host "$settingsPath exists. Moving..."
    Move-Item $settingsPath $codePath\old-settings.json
}

if (-not ($settingIsSymlink)) {
    cmd /C "mklink ""$settingsPath"" ""$PSScriptRoot\vscode\settings.json"""
}
else {
    Write-Host "settings.json already symlinked. Skipping."
}
