param ([string]$ScriptsPath)
$ErrorCount = 0
$sqlFiles = Get-ChildItem -Path $ScriptsPath -Recurse -Filter "*.sql"
foreach ($file in $sqlFiles) {
    $statements = (Get-Content $file.FullName -Raw) -replace '(?ms)/\*.*?\*/', '' -replace '--.*$', '' -split '(?i)\bGO\b|;'
    foreach ($stmt in $statements) {
        $trimmed = $stmt.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed)) { continue }
        if ($trimmed -match '(?i)\bTRUNCATE\s+TABLE\b' -or $trimmed -match '(?i)\bDROP\s+(TABLE|DATABASE)\b') {
            Write-Error "Unsafe DROP/TRUNCATE in $($file.Name)"; $ErrorCount++
        }
        if ($trimmed -match '(?i)\b(UPDATE|DELETE)\b' -and $trimmed -notmatch '(?i)\bWHERE\b') {
            Write-Error "Missing WHERE clause in $($file.Name)"; $ErrorCount++
        }
    }
}
if ($ErrorCount -gt 0) { exit 1 } else { Write-Host "All SQL scripts passed safety validation." }