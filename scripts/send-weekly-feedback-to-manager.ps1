param(
  [string]$To = "daniela@zenatech.com",
  [string]$Week = "",
  [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Get-ConfigValue {
  param([string]$Config, [string]$Name)
  return [regex]::Match($Config, ($Name + ':\s*"([^"]+)"')).Groups[1].Value
}

function Get-Field {
  param($Row, [string[]]$Names)
  foreach ($name in $Names) {
    if ($null -ne $Row.PSObject.Properties[$name]) {
      return [string]$Row.PSObject.Properties[$name].Value
    }
  }
  return ""
}

function Canonical {
  param([string]$Value)
  return (($Value -replace '\s+', ' ').Trim()).ToLowerInvariant()
}

function Average {
  param($Values)
  $numbers = @($Values | Where-Object { $_ -ne $null -and "$_" -ne "" } | ForEach-Object { [double]$_ })
  if ($numbers.Count -eq 0) { return 0 }
  return [math]::Round(($numbers | Measure-Object -Average).Average)
}

function Html {
  param([string]$Value)
  if ($null -eq $Value) { return "" }
  return [System.Net.WebUtility]::HtmlEncode($Value)
}

function Has-MeaningfulBlocker {
  param([string]$Value)
  if ([string]::IsNullOrWhiteSpace($Value)) { return $false }
  $n = (($Value -replace '\s+', ' ').Trim()).ToLowerInvariant()
  if ($n -match '^(no|none|n/?a|not applicable)([ .].*)?$') { return $false }
  if ($n -match '^no (current |major |technical )?blockers?([ .].*)?$') { return $false }
  return $true
}

function Format-DateValue {
  param([string]$Value)
  if (-not $Value) { return "" }
  $parsed = [datetime]::MinValue
  if ([datetime]::TryParse($Value, [ref]$parsed)) { return $parsed.ToString("MMM d, yyyy") }
  return $Value
}

function Health-Style {
  param([string]$Health)
  switch -Regex ($Health.ToLowerInvariant()) {
    "green|good|on.track" { return @{ Background = "#dcfce7"; Foreground = "#166534" } }
    "amber|yellow|watch|risk" { return @{ Background = "#fef3c7"; Foreground = "#92400e" } }
    "red|critical|blocked" { return @{ Background = "#fee2e2"; Foreground = "#991b1b" } }
    default { return @{ Background = "#e2e8f0"; Foreground = "#334155" } }
  }
}

function Build-OwnerSection {
  param($OwnerName, $Rows, [string]$ReportingWeek)

  $b = New-Object System.Text.StringBuilder
  $products = @($Rows | ForEach-Object { Get-Field $_ @("product") } | Where-Object { $_ } | Sort-Object -Unique)
  $avgProgress = Average @($Rows | ForEach-Object { Get-Field $_ @("progress") })
  $atRisk = @($Rows | Where-Object {
    (Get-Field $_ @("health")) -match "red|amber|risk|blocked" -or
    (Get-Field $_ @("priority")) -match "critical" -or
    (Has-MeaningfulBlocker (Get-Field $_ @("blocker", "blocker_risk", "blocker_or_risk", "risk")))
  }).Count

  [void]$b.Append("<tr><td style=`"padding:28px 30px 10px;background:#17324d;color:#fff;`">")
  [void]$b.Append("<h2 style=`"margin:0 0 4px;font-size:20px;`">$(Html $OwnerName)</h2>")
  [void]$b.Append("<div style=`"font-size:13px;color:#dbeafe;`">$($Rows.Count) reports | $($products.Count) products | $avgProgress% avg progress | $atRisk at risk</div>")
  [void]$b.Append("</td></tr>")

  if ($Rows.Count -eq 0) {
    [void]$b.Append("<tr><td style=`"padding:16px 30px;background:#fff;color:#64748b;`">No status reports submitted for this week.</td></tr>")
    return $b.ToString()
  }

  $sortedRows = $Rows | Sort-Object @{
    Expression = {
      $h = Get-Field $_ @("health")
      $p = Get-Field $_ @("priority")
      if ($h -match "red|blocked") { 1 }
      elseif ($p -match "critical") { 1 }
      elseif ($h -match "amber|risk") { 2 }
      elseif ($p -match "high") { 3 }
      else { 4 }
    }
  }

  foreach ($row in $sortedRows) {
    $product   = Get-Field $row @("product"); if (-not $product) { $product = "Product not set" }
    $ws        = Get-Field $row @("feature_workstream", "feature", "workstream"); if (-not $ws) { $ws = "Status report" }
    $health    = Get-Field $row @("health"); if (-not $health) { $health = "Not set" }
    $hs        = Health-Style $health
    $priority  = Get-Field $row @("priority")
    $progress  = Get-Field $row @("progress")
    $stage     = Get-Field $row @("stage")
    $dueDate   = Format-DateValue (Get-Field $row @("due_date", "end_date", "endDate"))
    $blocker   = Get-Field $row @("blocker", "blocker_risk", "blocker_or_risk", "risk")
    $next      = Get-Field $row @("next", "next_action", "nextAction", "next action")
    $summary   = Get-Field $row @("summary")
    $win       = Get-Field $row @("win")

    [void]$b.Append("<tr><td style=`"padding:16px 30px 0;`">")
    [void]$b.Append("<table width=`"100%`" cellpadding=`"0`" cellspacing=`"0`" style=`"border:1px solid #dbe3ec;border-collapse:collapse;margin-bottom:12px;`">")
    [void]$b.Append("<tr><td style=`"padding:12px 16px 8px;`"><strong style=`"font-size:16px;color:#17212b;`">$(Html $product)</strong> <span style=`"color:#94a3b8;`">|</span> <span style=`"color:#475569;`">$(Html $ws)</span></td></tr>")
    [void]$b.Append("<tr><td style=`"padding:4px 16px 8px;`">")
    [void]$b.Append("<span style=`"display:inline-block;margin:2px 4px 2px 0;padding:3px 8px;border-radius:10px;background:$($hs.Background);color:$($hs.Foreground);font-size:12px;font-weight:bold;`">$(Html $health)</span>")
    if ($priority) { [void]$b.Append("<span style=`"display:inline-block;margin:2px 4px 2px 0;padding:3px 8px;border-radius:10px;background:#e0e7ff;color:#3730a3;font-size:12px;`">$(Html $priority)</span>") }
    [void]$b.Append("<span style=`"display:inline-block;margin:2px 4px 2px 0;padding:3px 8px;border-radius:10px;background:#e2e8f0;color:#334155;font-size:12px;`">$(Html "$progress%")</span>")
    if ($dueDate) { [void]$b.Append("<span style=`"display:inline-block;margin:2px 4px 2px 0;padding:3px 8px;border-radius:10px;background:#f1f5f9;color:#334155;font-size:12px;`">Due: $(Html $dueDate)</span>") }
    [void]$b.Append("</td></tr>")
    if ($summary) { [void]$b.Append("<tr><td style=`"padding:6px 16px;border-top:1px solid #e2e8f0;`"><strong style=`"color:#334155;font-size:12px;`">Summary:</strong> <span style=`"color:#334155;`">$(Html $summary)</span></td></tr>") }
    if ($win) { [void]$b.Append("<tr><td style=`"padding:6px 16px;border-top:1px solid #e2e8f0;background:#f0fdf4;`"><strong style=`"color:#334155;font-size:12px;`">Win:</strong> <span style=`"color:#334155;`">$(Html $win)</span></td></tr>") }
    if (Has-MeaningfulBlocker $blocker) { [void]$b.Append("<tr><td style=`"padding:6px 16px;border-top:1px solid #e2e8f0;background:#fff7ed;`"><strong style=`"color:#334155;font-size:12px;`">Blocker/Risk:</strong> <span style=`"color:#334155;`">$(Html $blocker)</span></td></tr>") }
    if ($next) { [void]$b.Append("<tr><td style=`"padding:6px 16px;border-top:1px solid #e2e8f0;background:#eff6ff;`"><strong style=`"color:#334155;font-size:12px;`">Next action:</strong> <span style=`"color:#334155;`">$(Html $next)</span></td></tr>") }
    [void]$b.Append("</table></td></tr>")
  }
  return $b.ToString()
}

function As-Array {
  param($Value)
  if ($null -eq $Value) { return @() }
  if ($Value -is [System.Array]) { return @($Value) }
  return @($Value)
}

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$configPath = Join-Path $root "supabase-config.js"
$config = Get-Content -Raw $configPath
$url = Get-ConfigValue $config "url"
$anonKey = Get-ConfigValue $config "anonKey"
$emailEndpoint = Get-ConfigValue $config "emailFunctionUrl"
$emailKey = Get-ConfigValue $config "emailFunctionAnonKey"
if (-not $emailKey) { $emailKey = $anonKey }

$headers = @{ apikey = $anonKey; Authorization = "Bearer $anonKey" }
$emailHeaders = @{ apikey = $emailKey; Authorization = "Bearer $emailKey"; "Content-Type" = "application/json" }

$reports = As-Array (Invoke-RestMethod -Uri "$url/rest/v1/status_reports?select=*&order=week.desc&limit=5000" -Headers $headers -Method Get)
if ($reports.Count -eq 0) { Write-Output "No status reports found."; exit 0 }

$targetWeek = $Week
if (-not $targetWeek) {
  $targetWeek = @($reports | ForEach-Object { Get-Field $_ @("week") } | Where-Object { $_ } | Sort-Object -Descending | Select-Object -First 1)[0]
}
if (-not $targetWeek) { Write-Output "No reporting week found."; exit 0 }

$weekRows = @($reports | Where-Object { (Get-Field $_ @("week")) -eq $targetWeek })

# All known owners (same canonical list as send-weekly-feedback.ps1)
$aliases = @{
  "sam" = "Sam"; "saurabh" = "Sam"; "swati" = "Swati"; "swatti" = "Swati"
  "krishna" = "Krishna"; "krishina" = "Krishna"; "jojo" = "Jocasta"; "jocasta" = "Jocasta"
  "nadishani" = "Nadishani"; "deepa" = "Deepa"; "faran" = "Faran"; "riya" = "riya"
  "reza" = "REZA"; "sajjad" = "Sajjad"; "daniela" = "daniela"
}

$usersTable = Get-ConfigValue $config "usersTable"
if (-not $usersTable) { $usersTable = "app_users" }
$users = As-Array (Invoke-RestMethod -Uri "$url/rest/v1/${usersTable}?select=*&limit=5000" -Headers $headers -Method Get)

# Build display-name map: canonical -> display name from reports + users
$displayNames = @{}
foreach ($row in $reports) {
  $n = Get-Field $row @("owner")
  if ($n) { $key = Canonical $n; if (-not $displayNames[$key]) { $displayNames[$key] = $n } }
}
foreach ($user in $users) {
  $isActive = $true
  if ($null -ne $user.PSObject.Properties["active"]) { $isActive = [bool]$user.active }
  if ($null -ne $user.PSObject.Properties["is_active"]) { $isActive = [bool]$user.is_active }
  if (-not $isActive) { continue }
  $n = Get-Field $user @("display_name", "name")
  if ($n -and -not ($n -match '@')) {
    $key = Canonical $n
    if (-not $displayNames[$key]) { $displayNames[$key] = $n }
  }
}
foreach ($k in $aliases.Keys) {
  if (-not $displayNames[$k]) { $displayNames[$k] = $aliases[$k] }
}

# Group week rows by canonical owner, then add owners with no reports
$ownerGroups = @{}
foreach ($row in $weekRows) {
  $n = Get-Field $row @("owner")
  if ($n) {
    $key = Canonical $n
    if (-not $ownerGroups[$key]) { $ownerGroups[$key] = @() }
    $ownerGroups[$key] += $row
  }
}
foreach ($k in $displayNames.Keys) {
  if (-not $ownerGroups[$k]) { $ownerGroups[$k] = @() }
}

# Owner email map (same aliases as send-weekly-feedback.ps1)
$emailAliases = @{
  "sam" = "saurabh.jogdeo@zenatech.com"; "saurabh" = "saurabh.jogdeo@zenatech.com"
  "swati" = "swati.gurbani@zenatech.com"; "swatti" = "swati.gurbani@zenatech.com"
  "krishna" = "krishna@zenatech.com"; "krishina" = "krishna@zenatech.com"
  "jojo" = "jocasta@zenatech.com"; "jocasta" = "jocasta@zenatech.com"
  "nadishani" = "nadishani@zenatech.com"; "deepa" = "deepa@zenatech.com"
  "faran" = "faran@zenatech.com"; "riya" = "riya@zenatech.com"
  "reza" = "reza.boostani@zenatech.com"; "sajjad" = "sajjad@zenatech.com"
  "daniela" = "daniela@zenatech.com"
}
foreach ($user in $users) {
  $isActive = $true
  if ($null -ne $user.PSObject.Properties["active"]) { $isActive = [bool]$user.active }
  if ($null -ne $user.PSObject.Properties["is_active"]) { $isActive = [bool]$user.is_active }
  if (-not $isActive) { continue }
  $nm = Get-Field $user @("display_name", "name")
  $em = Get-Field $user @("email", "username")
  if ($nm -and $em -and $em -match '@') {
    $emailAliases[(Canonical $nm)] = $em
  }
}

# Build final deduplicated list: one entry per canonical email address
$seenEmails = @{}
$finalOwners = [System.Collections.Generic.List[object]]::new()
$systemNames = @("admin user", "master admin", "role manager")

$ownerList = $displayNames.Keys | Sort-Object

foreach ($key in $ownerList) {
  $ownerEmail = $emailAliases[$key]
  # Skip system/no-email owners
  if (-not $ownerEmail) { continue }
  $ownerDisplay = if ($displayNames[$key]) { $displayNames[$key] } else { $key }
  if ($systemNames -contains (Canonical $ownerDisplay)) { continue }
  # Deduplicate by email - keep entry with most reports
  if ($seenEmails.ContainsKey($ownerEmail)) {
    $existing = $finalOwners | Where-Object { $_.Email -eq $ownerEmail }
    if ($existing -and @($ownerGroups[$key]).Count -gt $existing.Rows.Count) {
      $existing.Name = $ownerDisplay
      $existing.Key = $key
      $existing.Rows = @($ownerGroups[$key])
    }
    continue
  }
  $seenEmails[$ownerEmail] = $true
  $finalOwners.Add([pscustomobject]@{
    Name = $ownerDisplay
    Key = $key
    Email = $ownerEmail
    Rows = @($ownerGroups[$key])
  }) | Out-Null
}

$sent = 0; $failed = 0

foreach ($ownerEntry in ($finalOwners | Sort-Object Name)) {
  $ownerName = $ownerEntry.Name
  $rows = @($ownerEntry.Rows)
  $key = $ownerEntry.Key
  $reportCount = $rows.Count

  # Build per-owner HTML section
  $section = Build-OwnerSection $ownerName $rows $targetWeek

  $htmlBody = @"
<div style="margin:0;padding:24px;background:#f1f5f9;font-family:Arial,sans-serif;color:#17212b;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:760px;margin:0 auto;background:#fff;border:1px solid #dbe3ec;border-collapse:collapse;">
<tr><td style="padding:24px 30px 16px;background:#17324d;color:#fff;">
  <div style="font-size:11px;letter-spacing:1.4px;font-weight:bold;color:#93c5fd;">OMENA CONSULTING - MANAGER COPY</div>
  <h1 style="margin:6px 0 4px;font-size:22px;">Weekly Owner Feedback</h1>
  <div style="font-size:14px;color:#dbeafe;">Week: $(Html $targetWeek) &nbsp;|&nbsp; Owner: $(Html $ownerName) &nbsp;|&nbsp; $reportCount report$(if($reportCount -ne 1){"s"})</div>
</td></tr>
$section
<tr><td style="padding:14px 30px;border-top:1px solid #dbe3ec;background:#f8fafc;color:#64748b;font-size:12px;">
  This copy was sent to you as manager because direct delivery to the owner is currently unavailable. Please forward as needed.
</td></tr>
</table></div>
"@

  $textBody = "Weekly feedback for owner: $ownerName`nWeek: $targetWeek`nReports: $reportCount`n`nThis is a manager copy. Please forward to $ownerName as needed."
  $subject = "Weekly Feedback - $ownerName | Week $targetWeek"

  if ($DryRun) {
    Write-Output "DRY RUN: would send to $To for owner $ownerName ($reportCount reports)"
    continue
  }

  try {
    $payload = @{
      mode = "feedback"
      to = $To
      email = $To
      displayName = "Daniela (for $ownerName)"
      subject = $subject
      message = $textBody
      htmlMessage = $htmlBody
    } | ConvertTo-Json -Depth 8

    Invoke-RestMethod -Uri $emailEndpoint -Headers $emailHeaders -Method Post -Body $payload | Out-Null
    Write-Output "SENT (manager copy): $ownerName -> $To"
    $sent += 1
  } catch {
    $errText = $_.Exception.Message
    if ($_.ErrorDetails.Message) { $errText = $_.ErrorDetails.Message }
    Write-Output "FAILED: $ownerName -> $To - $errText"
    $failed += 1
  }

  Start-Sleep -Milliseconds 300
}

Write-Output "Done. week=$targetWeek sent=$sent failed=$failed dryRun=$DryRun to=$To"
