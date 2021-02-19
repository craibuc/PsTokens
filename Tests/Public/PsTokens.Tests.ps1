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

        Context 'template' {
            BeforeAll {
                $ParameterName = 'template'
            }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'tokens' {
            BeforeAll {
                $ParameterName = 'tokens'
            }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is mandatory" {
                $Command | Should -HaveParameter $ParameterName -Mandatory
            }
        }

        Context 'Delimiter' {
            BeforeAll {
                $ParameterName = 'Delimiter'
            }

            It "is a [string]" {
                $Command | Should -HaveParameter $ParameterName -Type string
            }
            It "is optional" {
                $Command | Should -HaveParameter $ParameterName -Not -Mandatory
            }
        }

    }

    Context "when Template and Tokens parameters are supplied" {

        BeforeAll {
            # arrange
            $data=
                "/*
                Author:		__Author.Name__ <__Author.Email__>
                Analyst:	__Analyst.Name__ <__Analyst.Email__>
                ID:		__Id__
                Title:		__Title__
                */"
            
                $template = "TestDrive:\template.txt"
                Set-Content $template -value $data
            
                $tokens = @{
                    Id=9999; 
                    Title="Lorem ipsum dolor sit amet";
                    Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
                    Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
                }
            
                $document = "TestDrive:\document.txt"

        }

        BeforeEach {
            # act
            $content = Get-Content $template | Merge-Tokens -tokens $tokens
            Set-Content $document -value $content
        
        }

        It "Merges Id, Title" {        
            # assert
            ($document | Should Contain $tokens.Id and Should Contain $tokens.Title)
        }
    
        It "Merges Author information" {
            # assert
            ($document | Should Contain $tokens.Author.Name and Should Contain $tokens.Author.Email)
        }
    
        It "Merges Analyst information" {
            # assert
            ($document | Should Contain $tokens.Analyst.Name and Should Contain $tokens.Analyst.Email)
        }

    }

}