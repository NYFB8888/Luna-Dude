# ============================================
# START-DUDE.ps1
# Windows-native Dude bootstrap
# ============================================

Write-Host ""
Write-Host "=== Starting Dude ===" -ForegroundColor Cyan
Write-Host ""

# --- Ollama ---
$ollama = Get-Command ollama -ErrorAction SilentlyContinue

if (-not $ollama) {
    Write-Host "ERROR: Ollama was not found in PATH." -ForegroundColor Red
    exit 1
}

$ollamaRunning = Get-Process ollama -ErrorAction SilentlyContinue

if ($ollamaRunning) {
    Write-Host "Ollama is already running." -ForegroundColor Green
}
else {
    Write-Host "Starting Ollama..."
    Start-Process "ollama" -ArgumentList "serve"
    Start-Sleep -Seconds 3
}

# --- Open WebUI ---
$webui = "G:\LMG_AI\WebUI\.venv\Scripts\open-webui.exe"

if (-not (Test-Path $webui)) {
    Write-Host "ERROR: Open WebUI executable not found:" -ForegroundColor Red
    Write-Host $webui
    exit 1
}

$webuiRunning = Get-Process -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -eq $webui }

if ($webuiRunning) {
    Write-Host "Open WebUI is already running." -ForegroundColor Green
}
else {
    Write-Host "Starting Open WebUI..."
    Start-Process $webui -ArgumentList "serve"
}

Write-Host ""
Write-Host "=== Dude startup complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Open WebUI: http://127.0.0.1:8080"
Write-Host ""