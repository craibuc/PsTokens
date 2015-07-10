Write-Host "Importing module PsTokens..."

#
# load (dot-source) *.PS1 files, excluding unit-test scripts (*.Tests.*)
#
Get-ChildItem "$PSScriptRoot\*.ps1" | 
    Where-Object { $_.Name -like '*.ps1' -and $_.Name -notlike '__*' -and $_.Name -notlike '*.Tests*' } | 
    % {. $_}

Export-ModuleMember Merge-Tokens
Export-ModuleMember -Alias mt
