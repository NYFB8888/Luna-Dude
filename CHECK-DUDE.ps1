$OllamaPath = "E:\LMG_AI\Ollama\ollama.exe"
$WebUIPath = "G:\LMG_AI\WebUI\.venv\Scripts\open-webui.exe"

# --- Ollama executable ---
if (Test-Path $OllamaPath) {
    Write-Host "[OK] Ollama executable: $OllamaPath"
}
else {
    Write-Host "[FAIL] Ollama executable NOT FOUND: $OllamaPath"
}

# --- Ollama process ---
$OllamaProcess = Get-Process -Name "ollama" -ErrorAction SilentlyContinue

if ($OllamaProcess) {
    Write-Host "[OK] Ollama process running: PID $($OllamaProcess.Id)"
}
else {
    Write-Host "[FAIL] Ollama process NOT RUNNING"
}

# --- Ollama API ---
try {
    $Response = Invoke-RestMethod -Uri "http://127.0.0.1:11434/api/tags" -TimeoutSec 5
    Write-Host "[OK] Ollama API responding"
}
catch {
    Write-Host "[FAIL] Ollama API NOT responding"
}

# --- Open WebUI executable ---
if (Test-Path $WebUIPath) {
    Write-Host "[OK] Open WebUI executable: $WebUIPath"
}
else {
    Write-Host "[FAIL] Open WebUI executable NOT FOUND: $WebUIPath"
}

# --- Open WebUI process ---
$WebUIProcess = Get-Process -Name "open-webui" -ErrorAction SilentlyContinue

if ($WebUIProcess) {
    Write-Host "[OK] Open WebUI process running: PID $($WebUIProcess.Id)"
}
else {
    Write-Host "[FAIL] Open WebUI process NOT RUNNING"
}

# --- Open WebUI HTTP ---
try {
    $WebUIResponse = Invoke-WebRequest -Uri "http://127.0.0.1:8080" -TimeoutSec 5 -UseBasicParsing
    Write-Host "[OK] Open WebUI HTTP responding: $($WebUIResponse.StatusCode)"
}
catch {
    Write-Host "[FAIL] Open WebUI HTTP NOT responding"
}

# --- Ollama model inventory ---
try {
    $Models = Invoke-RestMethod -Uri "http://127.0.0.1:11434/api/tags" -TimeoutSec 5

    if ($Models.models.Count -gt 0) {
        Write-Host "[OK] Ollama models found: $($Models.models.Count)"
        $Models.models | ForEach-Object {
            Write-Host "     $($_.name)"
        }
    }
    else {
        Write-Host "[WARN] Ollama API responding, but no models found"
    }
}
catch {
    Write-Host "[FAIL] Could not retrieve Ollama model inventory"
}

# --- Ollama running model / GPU status ---
try {
    $RunningModels = & $OllamaPath ps 2>$null
    $Lines = @($RunningModels)

    if ($Lines.Count -gt 1) {
        Write-Host "[OK] Ollama running model:"
        $Lines | ForEach-Object {
            Write-Host "     $_"
        }
    }
    else {
        Write-Host "[WARN] Ollama running, but no model currently loaded"
    }
}
catch {
    Write-Host "[FAIL] Could not query Ollama running models"
}

# --- NVIDIA GPU ---
try {
    $GPU = & nvidia-smi --query-gpu=name,driver_version,memory.total,memory.used,utilization.gpu --format=csv,noheader 2>$null

    if ($GPU) {
        Write-Host "[OK] NVIDIA GPU:"
        Write-Host "     $GPU"
    }
    else {
        Write-Host "[FAIL] NVIDIA GPU not detected"
    }
}
catch {
    Write-Host "[FAIL] nvidia-smi not available"
}
