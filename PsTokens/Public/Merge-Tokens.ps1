<#
.SYNOPSIS
Replaces tokens in a block of text with a specified value.

.DESCRIPTION
Replaces tokens in a block of text with a specified value.

.PARAMETER Template
The block of text that contains text and tokens to be replaced.

.PARAMETER Tokens
Token name/value hashtable.

.EXAMPLE
 $content = Get-Content .\Template.txt | Merge-Tokens -Tokens @{FirstName: 'foo'; LastName: 'bar'}

Pass template to function via pipeline.

.NOTES
Core logic based on Stackoverflow answer: http://stackoverflow.com/a/29041580/134367

#>
function Merge-Tokens() {

    [CmdletBinding()] 
    
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [AllowEmptyString()]
        [String]$Template,

        [Parameter(Mandatory)]
        [HashTable]$Tokens,

        [Parameter()]
        [string[]]$Delimiter = '__'
    ) 

    begin {}

    process 
    {
        try {

            if ($Delimiter.Count -eq 1)
            {
              $Front, $Rear = $Delimiter[0],$Delimiter[0]
            }
            elseif ($Delimiter.Count -eq 2)
            {
              $Front, $Rear = $Delimiter[0],$Delimiter[1]
            }
            else
            {
              throw "Invalid delimiters: $( $Delimiter -join ',' )"
            }

            [regex]::Replace( $Template, "$Front(?<tokenName>[\w\.]+)$Rear", {
              # __TOKEN__
              param($match)

              $tokenName = $match.Groups['tokenName'].Value
              Write-Debug $tokenName
              
              $tokenValue = Invoke-Expression "`$Tokens.$tokenName"
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

    end {}

} 
