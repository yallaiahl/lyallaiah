Allure report setup for Robot Framework
=====================================

This project includes a helper to run Robot Framework tests with the Allure listener and generate an HTML report.

1. Install Python dependencies:

```powershell
python -m pip install -r requirements.txt
```

2. Run tests and produce Allure results (example runs all tests):

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\run_with_allure.ps1 -Tests tests
```

3. If the Allure CLI is installed (`allure` on PATH), the script will generate an HTML report in `allure-report/`.
   If not installed, install Allure following https://docs.qameta.io/allure/ and rerun, or upload `allure-results/` to your CI.

Notes:
- The script runs Robot with the listener `allure_robotframework` which is provided by the `allure-robotframework` package.
- The Robot run will also create regular Robot `results_...` output folders; Allure data will be in `allure-results`.
