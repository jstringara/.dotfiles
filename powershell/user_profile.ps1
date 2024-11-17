# theme: hacker
#oh-my-posh init pwsh --config 'C:\Users\jacop\AppData\Local\Programs\oh-my-posh\themes\microverse-power.omp.json' | Invoke-Expression
oh-my-posh init pwsh --config 'C:\Users\jacop\AppData\Local\Programs\oh-my-posh\themes\powerlevel10K_rainbow.omp.json' | Invoke-Expression

# PSReadLine
# Mode indicator
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PsReadLineOption -EditMode Vi
# set the cursor to the function above
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
# Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
$env:EDITOR = $env:VISUAL = 'nvim'

# Terminal Icons
Import-Module -Name Terminal-Icons

# Aliases
Set-Alias vim nvim
Set-Alias g git

# Utilities
function which ($cmd) {
  Get-Command -Name $cmd -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch {	
  set-content -Path ($args[0]) -Value ($null)
} 

function ll {
    Get-ChildItem | Format-Wide -Column 3
}


# import thee oh-my-posh autocomplete from 'autocomplete.ps1'
. $env:USERPROFILE\.config\powershell\autocomplete.ps1

# set the XDG_CONFIG_HOME
$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"

# change the git config position
$env:GIT_CONFIG_GLOBAL = "$env:USERPROFILE\.config\.gitconfig"

# Run the winfetch script
#winfetch
fastfetch
