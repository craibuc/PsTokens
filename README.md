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

## Email Merge

Send email messages to a list, pausing as desired as to not get caught by server rules.

```powershell
# gmail settings
$smtpServer = 'smtp.gmail.com'
$port = 587
$credential = Get-Credential

$from = 'First Last <first.last@gmail.com>'
$recipients = @(
    @{firstName='Foo';lastName='Bar';address='foo.bar@domain.com'},
    @{firstName='Bar';lastName='Foo';address='bar.foo@domain.com'},
    @{firstName='Jane';lastName='Doe';address='jane.doe@domain.com'},
    @{firstName='John';lastName='Doe';address='john.doe@domain.com'}
    )
$subject = 'lorem ipsum'

# tokens are cAsE SenSitivE and must match the values in the recipient list
$template = @"
Dear __firstName__ __lastName__,

Veniam ratione velit tenetur sunt eligendi. Veniam commodi et ut voluptates sint nulla eos. Sint ut sunt nisi occaecati tempore non. Minima cupiditate quis quia incidunt dolore distinctio qui.

First Last
"@

$counter=0
$wait=5 # time to wait between batches of messages
$batchSize = 2 # number of messages to send in each batch

$recipients | % {

    $counter+=1

    Write-Verbose "Sending message to $($_.firstName) $($_.lastName) <$($_.address)>"

    # replace values in template w/ hash's values
    $body = $template | Merge-Tokens -tokens $_
    Write-Verbose "----------`n$body"

    Send-MailMessage -SmtpServer $smtpserver -Port $port -UseSsl -Credential $credential -From $from -To $_.address -Subject $subject -Body $body 

    if ($counter % $batchSize -eq 0) {
        Write-Verbose "Sleeping for $wait seconds..."
        Start-Sleep -s $wait
    }

}

Write-Verbose "Sent $counter messages"
```

## Contributions
* Based on the work of Brice Lambson; https://gist.github.com/bricelam/a5debdbfc495eb7b116c and http://www.bricelam.net/2012/09/simple-template-engine-for-powershell.html.
* Craig Buchanan
