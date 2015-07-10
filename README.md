# PsTokens
PowerShell token-replacement library.

## Usage

```powershell
PS> $content = Get-Content .\template.txt | Merge-Tokens -tokens @{FirstName: 'foo'; LastName: 'bar'}
```

## Contributions
* Based on the work of Brice Lambson; https://gist.github.com/bricelam/a5debdbfc495eb7b116c and http://www.bricelam.net/2012/09/simple-template-engine-for-powershell.html.
