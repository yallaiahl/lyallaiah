# CI for RobotMCP

This project runs Robot Framework tests on GitHub Actions.

How the workflow runs
- Workflow file: `.github/workflows/robot-ci.yml` (root)
- It installs Python and dependencies from `robotmcp_project/requirements.txt`.
- It runs tests from `robotmcp_project/tests` and uploads the `results` directory as an artifact.

Run tests locally
- From project root (Windows PowerShell):
```
pip install -r robotmcp_project/requirements.txt
.
powershell -File scripts\run_robot_tests.ps1
```
- From macOS / Linux bash:
```
python -m pip install -r robotmcp_project/requirements.txt
bash scripts/run_robot_tests.sh
```

Triggering CI on GitHub
- Commit and push your changes to `main` or open a pull request. The workflow triggers on push and pull requests.

Inspecting results
- The workflow uploads test outputs as an artifact named `robot-results` (downloadable from the Actions run). Locally, results are written to the `results` directory.
