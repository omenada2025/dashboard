# Apply the Training lifecycle migration to Supabase via SQL Editor.
# Safe to run multiple times (uses drop/add constraint pattern).

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$migration = Join-Path $root "supabase\migrations\20260821150000_training_lifecycle.sql"
$projectRef = "vwvmfuktrkpzrzlklbkr"
$sqlEditorUrl = "https://supabase.com/dashboard/project/$projectRef/sql/new"

if (-not (Test-Path $migration)) {
  throw "Migration file not found: $migration"
}

$sql = Get-Content $migration -Raw
Write-Host ""
Write-Host "Training lifecycle migration"
Write-Host "Project: $projectRef"
Write-Host "File:    $migration"
Write-Host ""
Write-Host "Steps:"
Write-Host "1. Open Supabase SQL Editor:"
Write-Host "   $sqlEditorUrl"
Write-Host "2. Paste the migration SQL below (or from the file)."
Write-Host "3. Click Run."
Write-Host "4. Refresh the dashboard and save a report with role = Training."
Write-Host ""

try {
  Set-Clipboard -Value $sql
  Write-Host "Migration SQL copied to clipboard."
} catch {
  Write-Host "Could not copy to clipboard. Open the migration file manually."
}

Write-Host ""
Write-Host "----- SQL START -----"
Write-Host $sql
Write-Host "----- SQL END -----"
Write-Host ""

try {
  Start-Process $sqlEditorUrl | Out-Null
  Write-Host "Opened Supabase SQL Editor in your browser."
} catch {
  Write-Host "Open the SQL Editor manually: $sqlEditorUrl"
}
