# $here = Split-Path -Parent $MyInvocation.MyCommand.Path
# $sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
# . "$here\$sut"

Import-Module PsTokens -Force

Describe "Merge-Tokens" {

    $tokens = @{
        Id=9999; 
        Title="Lorem ipsum dolor sit amet";
        Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
        Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
    }

    $testPath = "TestDrive:\result.txt"

    $content = Get-Content .\template.txt | Merge-Tokens -tokens $tokens
    Set-Content $testPath -value $content

    It "Merges Id, Title" {
        ($testPath | Should Contain $tokens.Id and Should Contain $tokens.Title)
    }

    It "Merges Author information" {
        ($testPath | Should Contain $tokens.Author.Name and Should Contain $tokens.Author.Email)
    }

    It "Merges Analyst information" {
        ($testPath | Should Contain $tokens.Analyst.Name and Should Contain $tokens.Analyst.Email)
    }

    Write-Host $content

}
