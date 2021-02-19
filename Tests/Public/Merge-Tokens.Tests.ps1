BeforeAll {

    # /Paths
    $ProjectDirectory = Split-Path -Path (Split-Path -Path $PSScriptRoot -Parent) -Parent
    $PublicPath = Join-Path $ProjectDirectory "/PsTokens/Public/"

    $SUT = (Split-Path -Leaf $PSCommandPath) -replace '\.Tests\.', '.'

    $Path = Join-Path $PublicPath $SUT
    Write-Host "Path: $Path"

    . (Join-Path $PublicPath $SUT)

}

Describe "Merge-Tokens" -Tag 'unit' {

    Context "Parameter validation" {

        BeforeAll {
            $Command = Get-Command 'Merge-Tokens'
        }

        Context 'Template' {
            BeforeAll {
                $ParameterName = 'Template'
            }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'Tokens' {
            BeforeAll {
                $ParameterName = 'Tokens'
            }

            It "is a [hashtable]" {
                $Command | Should -HaveParameter $ParameterName -Type hashtable
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'Delimiter' {
            BeforeAll {
                $ParameterName = 'Delimiter'
            }

            It "is a [string[]]" {
                $Command | Should -HaveParameter $ParameterName -Type string[]
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

    }

    Context "when Template and Tokens parameters are supplied" {

        BeforeAll {
            # arrange
            $Data = 
                "/*
                Author:		__Author.Name__ <__Author.Email__>
                Analyst:	__Analyst.Name__ <__Analyst.Email__>
                ID:		__Id__
                Title:		__Title__
                */"
            
            $Tokens = @{
                Id=9999; 
                Title="Lorem ipsum dolor sit amet";
                Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
                Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
            }
        }

        BeforeEach {
            # act
            $Actual = $Data | Merge-Tokens -Tokens $Tokens
        }

        It "merges tokens correctly" {        
            # assert
            $Actual | Should -BeLike "*$($Tokens.Id)*"
            $Actual | Should -BeLike "*$($Tokens.Id)*"
            $Actual | Should -BeLike "*$($Tokens.Author.Name)*"
            $Actual | Should -BeLike "*$($Tokens.Author.Email)*"
            $Actual | Should -BeLike "*$($Tokens.Analyst.Name)*"
            $Actual | Should -BeLike "*$($Tokens.Analyst.Email)*"
        }

    }

    Context "when Delimiter is provided" {
        BeforeAll {
            # arrange
            $Data =
                "/*
                Author:		{Author.Name} <{Author.Email}>
                Analyst:    {Analyst.Name} <{Analyst.Email}>
                ID:		    {Id}
                Title:		{Title}
                */"

            $Tokens = @{
                Id=9999; 
                Title="Lorem ipsum dolor sit amet";
                Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
                Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
            }

            $Delimiter = @( '{', '}')
        }

        BeforeEach {
            # act
            $Actual = $Data | Merge-Tokens -Tokens $Tokens -Delimiter $Delimiter
        }

        It "merges tokens correctly" {
            # assert
            $Actual | Should -BeLike "*$($Tokens.Id)*"
            $Actual | Should -BeLike "*$($Tokens.Id)*"
            $Actual | Should -BeLike "*$($Tokens.Author.Name)*"
            $Actual | Should -BeLike "*$($Tokens.Author.Email)*"
            $Actual | Should -BeLike "*$($Tokens.Analyst.Name)*"
            $Actual | Should -BeLike "*$($Tokens.Analyst.Email)*"
        }

    }

    Context "when an invalid Delimiter is provided" {
        BeforeAll {
            # arrange
            $Data =
                "/*
                Author:		{Author.Name} <{Author.Email}>
                Analyst:    {Analyst.Name} <{Analyst.Email}>
                ID:		    {Id}
                Title:		{Title}
                */"

            $Tokens = @{
                Id=9999; 
                Title="Lorem ipsum dolor sit amet";
                Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
                Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
            }

            $Delimiter = @('{','}','[')
        }
        It "throws an exception" {        
            { $Data | Merge-Tokens -Tokens $Tokens -Delimiter $Delimiter -ErrorAction Stop } | Should -Throw
        }
    }

}