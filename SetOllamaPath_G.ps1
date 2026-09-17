Write-Host "=== Setting Ollama models to G (standard) ===" -ForegroundColor Cyan
$newPath = "G:\LMG_AI\Ollama_models"

# 1. Save permanently to the Windows User environment
[Environment]::SetEnvironmentVariable("OLLAMA_MODELS", $newPath, "User")

# 2. Update the current PowerShell session so Write-Host can see it right now
$env:OLLAMA_MODELS = $newPath

Write-Host "OLLAMA_MODELS set to " $env:OLLAMA_MODELS -ForegroundColor Yellow 

Write-Host "`nSuccess! OLLAMA_MODELS has been updated to: $newPath" -ForegroundColor Green
Write-Host "IMPORTANT: Please quit Ollama from your system tray (bottom-right taskbar) and reopen it for changes to take effect." -ForegroundColor Yellow

Stop-Process -Name "ollama" -Force -ErrorAction SilentlyContinue
