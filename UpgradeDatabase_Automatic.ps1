param (
    [string]$TargetConnectionString = "Server=localhost;Database=TestDB;Integrated Security=True;",
    [string]$PublishProfilePath = "DacPacs\TestDB.Upgrade.publish.xml",
    [string]$DacpacPath = "TestDB\bin\Debug\TestDB.dacpac"
)
Write-Host "Target Environment Identified."
Write-Host "Executing sqlpackage.exe deployment targeting $TargetConnectionString" 