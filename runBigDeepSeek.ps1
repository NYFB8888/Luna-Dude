Write-Host "=== Starting DeepSeek ===" -ForegroundColor Cyan
Measure-Command { ollama run deepseek-r1:32b }