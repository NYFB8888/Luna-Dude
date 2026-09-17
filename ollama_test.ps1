Write-Host "=== Starting ===" -ForegroundColor Cyan

Write-Host "deepseek-r1:32b"
Measure-Command { ollama run deepseek-r1:32b "hello"}
ollama stop deepseek-r1:32b

Write-Host "deepseek-r1:32b"
Measure-Command { ollama run deepseek-r1:32b "hello"}
ollama stop deepseek-r1:32b

Write-Host "deepseek-r1:14b "
Measure-Command { ollama run deepseek-r1:14b  "hello"}
ollama stop deepseek-r1:14b 

Write-Host "qwen3:30b"
Measure-Command { ollama run qwen3:30b "hello"}
ollama stop qwen3:30b