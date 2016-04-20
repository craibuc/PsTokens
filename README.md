# PsTokens
PowerShell token-replacement library.

## Usage

Tokens follow the pattern `__TokenName__` (case insensitive).

Assuming that the content of `.\template.txt` is:

```
FN: __FirstName__
LN: __LastName__
```

This PowerShell script:

```powershell
PS> $content = Get-Content .\template.txt | Merge-Tokens -tokens @{'FirstName' = 'foo'; 'LastName' = 'bar'}
```

Will populate the `$content` variable with this text:

```
FN: Foo
LN: Bar
```

## Contributions
* Based on the work of Brice Lambson; https://gist.github.com/bricelam/a5debdbfc495eb7b116c and http://www.bricelam.net/2012/09/simple-template-engine-for-powershell.html.
* Craig Buchanan
