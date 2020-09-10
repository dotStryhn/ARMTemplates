$TestsFiles = Get-ChildItem -Recurse -File | Where-Object { $_.Name -eq 'Test-ARMTemplates.Tests.ps1' }

foreach($TestFile in $TestsFiles) {

    Set-Location $TestFile.Directory.FullName
    Invoke-Pester $TestFile -Output 'Diagnostic'

}

Set-Location $PSScriptRoot