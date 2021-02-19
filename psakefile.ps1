Properties {
    $ModuleName='PsTokens'
  }
  
  Task Symlink -description "Create a symlink for '$ModuleName' module" {
      $Here = Get-Location
      Push-Location ~/.local/share/powershell/Modules
      ln -s "$Here/$ModuleName" $ModuleName
      Pop-Location
  }