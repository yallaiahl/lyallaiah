param(
    [string]$Tests = "tests",
    [string]$PythonPath = "src",
    [string]$AllureResults = "allure-results",
    [string]$AllureReport = "allure-report"
)

Write-Host "Running Robot Framework tests with Allure listener..."

# Ensure results directory is clean
if (Test-Path $AllureResults) { Remove-Item -Recurse -Force $AllureResults }
New-Item -ItemType Directory -Force -Path $AllureResults | Out-Null

$robotCmd = "robot --pythonpath $PythonPath --listener allure_robotframework --outputdir results_$AllureResults $Tests"
Write-Host "Executing: $robotCmd"
& cmd /c $robotCmd

Write-Host "Robot run finished. Allure results should be in .\$AllureResults or .\results_$AllureResults"

# Generate Allure report if CLI available
if (Get-Command allure -ErrorAction SilentlyContinue) {
    Write-Host "Generating Allure HTML report..."
    if (Test-Path $AllureReport) { Remove-Item -Recurse -Force $AllureReport }
    & allure generate $AllureResults -o $AllureReport --clean
    Write-Host "Allure report generated at .\$AllureReport"
} else {
    Write-Host "Allure CLI not found. Install from https://docs.qameta.io/allure/ to generate HTML reports locally."
    Write-Host "You can still view results with 'allure serve' if CLI is available, or upload $AllureResults to CI that supports Allure." 
}
