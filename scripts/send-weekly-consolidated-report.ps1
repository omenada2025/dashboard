param(
  [switch]$DryRun,
  [switch]$AllProductManagers,
  [string]$Week = "",
  [string]$To = "daniela@zenatech.com"
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

function Html {
  param([string]$Value)
  if ($null -eq $Value) { return "" }
  return [System.Net.WebUtility]::HtmlEncode($Value)
}

function Average {
  param($Values)
  $numbers = @($Values | Where-Object { $_ -ne $null -and "$_" -ne "" } | ForEach-Object { [double]$_ })
  if ($numbers.Count -eq 0) { return 0 }
  return [math]::Round(($numbers | Measure-Object -Average).Average)
}

function Format-DateValue {
  param([string]$Value)
  if (-not $Value) { return "" }
  $parsed = [datetime]::MinValue
  if ([datetime]::TryParse($Value, [ref]$parsed)) {
    return $parsed.ToString("MMM d, yyyy")
  }
  return $Value
}

function Add-Detail {
  param(
    [System.Text.StringBuilder]$Builder,
    [string]$Label,
    [string]$Value,
    [string]$Background = "#f8fafc"
  )
  if (-not [string]::IsNullOrWhiteSpace($Value)) {
    [void]$Builder.Append("<tr><td style=`"padding:10px 12px;border-top:1px solid #e2e8f0;background:$Background;`"><strong style=`"color:#334155;`">$(Html $Label)</strong><br><span style=`"color:#334155;`">$(Html $Value)</span></td></tr>")
  }
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

function Has-MeaningfulBlocker {
  param([string]$Value)
  if ([string]::IsNullOrWhiteSpace($Value)) { return $false }
  $normalized = (($Value -replace '\s+', ' ').Trim()).ToLowerInvariant()
  if ($normalized -match '^(no|none|n/?a|not applicable)([ .].*)?$') { return $false }
  if ($normalized -match '^no (current |major |technical )?blockers?([ .].*)?$') { return $false }
  return $true
}

$root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$config = Get-Content -Raw (Join-Path $root "supabase-config.js")
$url = Get-ConfigValue $config "url"
$anonKey = Get-ConfigValue $config "anonKey"
$emailEndpoint = Get-ConfigValue $config "emailFunctionUrl"
$emailKey = Get-ConfigValue $config "emailFunctionAnonKey"
if (-not $emailKey) { $emailKey = $anonKey }

$headers = @{ apikey = $anonKey; Authorization = "Bearer $anonKey" }
$emailHeaders = @{ apikey = $emailKey; Authorization = "Bearer $emailKey"; "Content-Type" = "application/json" }
$reports = @((Invoke-RestMethod -Uri "$url/rest/v1/status_reports?select=*&order=week.desc&limit=5000" -Headers $headers -Method Get) | ForEach-Object { $_ })

if ($reports.Count -eq 0) {
  Write-Output "No status reports found."
  exit 0
}

$targetWeek = $Week
if (-not $targetWeek) {
  $targetWeek = @($reports | ForEach-Object { Get-Field $_ @("week") } | Where-Object { $_ } | Sort-Object -Descending | Select-Object -First 1)[0]
}

$weekRows = @($reports | Where-Object { (Get-Field $_ @("week")) -eq $targetWeek })
$periodLabel = $targetWeek
if ($AllProductManagers) {
  # Include every Product Manager's projects from that PM's most recent submitted week.
  $weekRows = @()
  $pmRows = @($reports | Where-Object { (Get-Field $_ @("role")) -eq "Product Manager" -and (Get-Field $_ @("owner")) })
  foreach ($ownerGroup in ($pmRows | Group-Object { Get-Field $_ @("owner") })) {
    $ownerWeek = @($ownerGroup.Group | ForEach-Object { Get-Field $_ @("week") } | Where-Object { $_ } | Sort-Object -Descending | Select-Object -First 1)[0]
    if ($ownerWeek) {
      $weekRows += @($ownerGroup.Group | Where-Object { (Get-Field $_ @("week")) -eq $ownerWeek })
    }
  }
  $periodLabel = "Latest submitted week per Product Manager"
}
if ($weekRows.Count -eq 0) {
  throw "No status reports found for reporting period $periodLabel."
}

$groups = @($weekRows | Group-Object { Get-Field $_ @("owner") } | Where-Object { $_.Name } | Sort-Object Name)
$ownerCount = $groups.Count
$averageProgress = Average @($weekRows | ForEach-Object { Get-Field $_ @("progress") })
$atRiskCount = @($weekRows | Where-Object {
  $health = Get-Field $_ @("health")
  $priority = Get-Field $_ @("priority")
  $blocker = Get-Field $_ @("blocker", "blocker_risk", "blocker_or_risk", "risk")
  $health -match "red|amber|risk|blocked" -or $priority -match "critical" -or (Has-MeaningfulBlocker $blocker)
}).Count

$plain = New-Object System.Collections.Generic.List[string]
$plain.Add("Omena Consulting | All Product Managers Status | $periodLabel")
$plain.Add("Reports: $($weekRows.Count) | Owners: $ownerCount | Average progress: $averageProgress% | At risk: $atRiskCount")
$plain.Add("")

$html = New-Object System.Text.StringBuilder
[void]$html.Append('<div style="margin:0;padding:24px;background:#f1f5f9;font-family:Arial,sans-serif;color:#17212b;">')
[void]$html.Append('<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:760px;margin:0 auto;background:#ffffff;border:1px solid #dbe3ec;border-collapse:collapse;">')
[void]$html.Append("<tr><td style=`"padding:28px 30px;background:#17324d;color:#ffffff;`"><div style=`"font-size:12px;letter-spacing:1.4px;font-weight:bold;`">OMENA CONSULTING</div><h1 style=`"margin:8px 0 4px;font-size:26px;line-height:1.25;`">All Product Managers Status</h1><div style=`"font-size:15px;color:#dbeafe;`">Reporting period: $(Html $periodLabel)</div></td></tr>")
[void]$html.Append('<tr><td style="padding:26px 30px;">')
[void]$html.Append('<p style="margin:0 0 8px;font-size:16px;">Hello Daniela,</p><p style="margin:0 0 22px;color:#475569;">Here is the consolidated weekly status report for all owners.</p>')
[void]$html.Append('<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;margin-bottom:24px;"><tr>')
$metrics = @(
  @{ Label = "Reports"; Value = $weekRows.Count },
  @{ Label = "Owners"; Value = $ownerCount },
  @{ Label = "Avg. progress"; Value = "$averageProgress%" },
  @{ Label = "At risk"; Value = $atRiskCount }
)
foreach ($metric in $metrics) {
  [void]$html.Append("<td width=`"25%`" style=`"padding:12px;border:1px solid #dbe3ec;vertical-align:top;`"><div style=`"font-size:12px;color:#64748b;margin-bottom:5px;`">$(Html $metric.Label)</div><div style=`"font-size:22px;font-weight:bold;color:#17324d;`">$(Html "$($metric.Value)")</div></td>")
}
[void]$html.Append('</tr></table>')

[void]$html.Append('<table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;margin-bottom:28px;"><thead><tr style="background:#f8fafc;"><th align="left" style="padding:10px 8px;border-bottom:1px solid #cbd5e1;color:#475569;">Owner</th><th align="right" style="padding:10px 8px;border-bottom:1px solid #cbd5e1;color:#475569;">Reports</th><th align="right" style="padding:10px 8px;border-bottom:1px solid #cbd5e1;color:#475569;">Avg. progress</th><th align="right" style="padding:10px 8px;border-bottom:1px solid #cbd5e1;color:#475569;">At risk</th></tr></thead><tbody>')
foreach ($group in $groups) {
  $ownerRows = @($group.Group)
  $ownerAverage = Average @($ownerRows | ForEach-Object { Get-Field $_ @("progress") })
  $ownerAtRisk = @($ownerRows | Where-Object {
    (Get-Field $_ @("health")) -match "red|amber|risk|blocked" -or
    (Get-Field $_ @("priority")) -match "critical" -or
    (Has-MeaningfulBlocker (Get-Field $_ @("blocker", "blocker_risk", "blocker_or_risk", "risk")))
  }).Count
  [void]$html.Append("<tr><td style=`"padding:10px 8px;border-bottom:1px solid #e2e8f0;`">$(Html $group.Name)</td><td align=`"right`" style=`"padding:10px 8px;border-bottom:1px solid #e2e8f0;`">$($ownerRows.Count)</td><td align=`"right`" style=`"padding:10px 8px;border-bottom:1px solid #e2e8f0;`">$ownerAverage%</td><td align=`"right`" style=`"padding:10px 8px;border-bottom:1px solid #e2e8f0;`">$ownerAtRisk</td></tr>")
}
[void]$html.Append('</tbody></table>')

foreach ($group in $groups) {
  $ownerRows = @($group.Group)
  $ownerAverage = Average @($ownerRows | ForEach-Object { Get-Field $_ @("progress") })
  $plain.Add("$($group.Name) | $($ownerRows.Count) reports | $ownerAverage% average")
  [void]$html.Append("<h2 style=`"margin:30px 0 14px;padding-bottom:9px;border-bottom:3px solid #17324d;font-size:21px;color:#17324d;`">$(Html $group.Name) <span style=`"font-size:14px;font-weight:normal;color:#64748b;`">| $($ownerRows.Count) reports | $ownerAverage% average</span></h2>")

  foreach ($row in ($ownerRows | Sort-Object product, feature_workstream)) {
    $product = Get-Field $row @("product")
    $workstream = Get-Field $row @("feature_workstream", "feature", "workstream")
    if (-not $workstream) { $workstream = "Status report" }
    if (-not $product) { $product = "Product not set" }
    $health = Get-Field $row @("health")
    if (-not $health) { $health = "Not set" }
    $healthStyle = Health-Style $health
    $priority = Get-Field $row @("priority")
    $actionStatus = Get-Field $row @("action_status")
    $progress = Get-Field $row @("progress")
    $stage = Get-Field $row @("stage")
    $dueDate = Format-DateValue (Get-Field $row @("due_date", "end_date", "endDate"))
    $actionDue = Format-DateValue (Get-Field $row @("action_due_date"))

    $plain.Add("- $product - $workstream | Health: $health | Progress: $progress%")
    [void]$html.Append('<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border:1px solid #dbe3ec;border-collapse:collapse;margin-bottom:16px;"><tr><td style="padding:16px 16px 12px;">')
    [void]$html.Append("<h3 style=`"margin:0 0 10px;font-size:18px;color:#17212b;`">$(Html $product) <span style=`"color:#94a3b8;`">|</span> $(Html $workstream)</h3>")
    [void]$html.Append("<span style=`"display:inline-block;margin:0 6px 6px 0;padding:4px 9px;border-radius:12px;background:$($healthStyle.Background);color:$($healthStyle.Foreground);font-size:12px;font-weight:bold;`">Health: $(Html $health)</span>")
    if ($priority) { [void]$html.Append("<span style=`"display:inline-block;margin:0 6px 6px 0;padding:4px 9px;border-radius:12px;background:#e0e7ff;color:#3730a3;font-size:12px;font-weight:bold;`">Priority: $(Html $priority)</span>") }
    if ($actionStatus) { [void]$html.Append("<span style=`"display:inline-block;margin:0 6px 6px 0;padding:4px 9px;border-radius:12px;background:#e2e8f0;color:#334155;font-size:12px;font-weight:bold;`">Action: $(Html $actionStatus)</span>") }
    [void]$html.Append('</td></tr><tr><td style="padding:0 16px 14px;"><table width="100%" cellpadding="0" cellspacing="0" style="border-collapse:collapse;background:#f8fafc;"><tr>')
    [void]$html.Append("<td width=`"25%`" style=`"padding:9px;border:1px solid #e2e8f0;vertical-align:top;`"><span style=`"font-size:12px;color:#64748b;`">Progress</span><br><strong>$(Html "$progress%")</strong></td>")
    [void]$html.Append("<td width=`"25%`" style=`"padding:9px;border:1px solid #e2e8f0;vertical-align:top;`"><span style=`"font-size:12px;color:#64748b;`">Stage</span><br><strong>$(Html $stage)</strong></td>")
    [void]$html.Append("<td width=`"25%`" style=`"padding:9px;border:1px solid #e2e8f0;vertical-align:top;`"><span style=`"font-size:12px;color:#64748b;`">Due date</span><br><strong>$(Html $dueDate)</strong></td>")
    [void]$html.Append("<td width=`"25%`" style=`"padding:9px;border:1px solid #e2e8f0;vertical-align:top;`"><span style=`"font-size:12px;color:#64748b;`">Action due</span><br><strong>$(Html $actionDue)</strong></td>")
    [void]$html.Append('</tr></table></td></tr>')
    Add-Detail $html "Summary" (Get-Field $row @("summary"))
    Add-Detail $html "Win" (Get-Field $row @("win")) "#f0fdf4"
    Add-Detail $html "Blocker / Risk" (Get-Field $row @("blocker", "blocker_risk", "blocker_or_risk", "risk")) "#fff7ed"
    Add-Detail $html "Dependency" (Get-Field $row @("dependency"))
    Add-Detail $html "Next action" (Get-Field $row @("next", "next_action", "nextAction", "next action")) "#eff6ff"
    Add-Detail $html "Action owner" (Get-Field $row @("action_owner"))
    Add-Detail $html "Decision needed" (Get-Field $row @("decision_needed")) "#fefce8"
    [void]$html.Append('</table>')
  }
  $plain.Add("")
}

[void]$html.Append('</td></tr><tr><td style="padding:18px 30px;border-top:1px solid #dbe3ec;background:#f8fafc;color:#64748b;font-size:12px;">Generated from each Product Manager''s latest submitted status reports.</td></tr></table></div>')

$message = $plain -join "`n"
$htmlMessage = $html.ToString()
$subject = "Omena Consulting | All Product Managers Status | $periodLabel"

if ($DryRun) {
  Write-Output "DRY RUN: week=$targetWeek allProductManagers=$AllProductManagers reports=$($weekRows.Count) owners=$ownerCount avgProgress=$averageProgress atRisk=$atRiskCount to=$To htmlLength=$($htmlMessage.Length)"
  exit 0
}

$payload = @{
  mode = "feedback"
  to = $To
  email = $To
  displayName = "Daniela"
  subject = $subject
  message = $message
  htmlMessage = $htmlMessage
} | ConvertTo-Json -Depth 10

$result = Invoke-RestMethod -Uri $emailEndpoint -Headers $emailHeaders -Method Post -Body $payload
Write-Output "Consolidated weekly report sent. week=$targetWeek allProductManagers=$AllProductManagers reports=$($weekRows.Count) owners=$ownerCount to=$To status=$($result.status) sentAt=$($result.sent_at)"
