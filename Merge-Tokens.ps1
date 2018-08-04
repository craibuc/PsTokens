<#
.SYNOPSIS
Replaces tokens in a block of text with a specified value.

.DESCRIPTION
Replaces tokens in a block of text with a specified value.

.PARAMETER template
The block of text that contains text and tokens to be replaced.

.PARAMETER tokens
Token name/value hashtable.

.EXAMPLE
 $content = Get-Content .\template.txt | Merge-Tokens -tokens @{FirstName: 'foo'; LastName: 'bar'}
Pass template to function via pipeline.

#>
function Merge-Tokens() {

    [CmdletBinding()] 
    
    param (
        [Parameter(Mandatory=$True, ValueFromPipeline=$true)]
        [AllowEmptyString()]
        [String] $template,

        [Parameter(Mandatory=$true)]
        [HashTable] $tokens
    ) 

    # begin { Write-Debug "$($MyInvocation.MyCommand.Name)::Begin" }

    process {
        # Write-Debug "$($MyInvocation.MyCommand.Name)::Process" 

        # adapted based on this Stackoverflow answer: http://stackoverflow.com/a/29041580/134367
        try {

            [regex]::Replace( $template, '__(?<tokenName>[\w\.]+)__', {
              # __TOKEN__
              param($match)

              $tokenName = $match.Groups['tokenName'].Value
              Write-Debug $tokenName
              
              $tokenValue = Invoke-Expression "`$tokens.$tokenName"
              Write-Debug $tokenValue

              if ($tokenValue) {
                # there was a value; return it
                return $tokenValue
              } 
              else {
                # non-matching token; return token
                return $match
              }
            })

        }
        catch {
            Write-Error $_
        }

    }

    # end { Write-Debug "$($MyInvocation.MyCommand.Name)::End" }

} 

Set-Alias mt Merge-Tokens