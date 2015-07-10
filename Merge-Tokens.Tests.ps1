$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$here\$sut"

Describe "Merge-Tokens" {

    #
    # arrange
    #

    $data=@"
/*
Author:		__Author.Name__ <__Author.Email__>
Analyst:	__Analyst.Name__ <__Analyst.Email__>
ID:		__Id__
Title:		__Title__
*/
"@

    $template = "TestDrive:\template.txt"
    Set-Content $template -value $data

    $tokens = @{
        Id=9999; 
        Title="Lorem ipsum dolor sit amet";
        Author= @{Name="John Doe"; Email='john.doe@domain.tdl'};
        Analyst= @{Name="Jane Doe"; Email='jane.doe@domain.tdl'}
    }

    $document = "TestDrive:\document.txt"

    #
    # act
    #

    $content = Get-Content $template | Merge-Tokens -tokens $tokens
    Set-Content $document -value $content

    It "Merges Id, Title" {
        
        # 
        # assert
        # 

        ($document | Should Contain $tokens.Id and Should Contain $tokens.Title)
    }

    It "Merges Author information" {

        # 
        # assert
        # 

        ($document | Should Contain $tokens.Author.Name and Should Contain $tokens.Author.Email)
    }

    It "Merges Analyst information" {

        # 
        # assert
        # 

        ($document | Should Contain $tokens.Analyst.Name and Should Contain $tokens.Analyst.Email)
    }

}
