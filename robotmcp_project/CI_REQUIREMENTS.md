# Robot Framework CI — Required files and folders

This file lists the files and folders the project expects to run Robot Framework tests both locally and in CI (GitHub Actions).

Required top-level files/folders
- `robotmcp_project/requirements.txt`: Python dependencies (must include `robotframework` and any libraries used by tests).
- `robotmcp_project/tests/`: Robot test suites (`.robot` files). CI runs tests from this folder.
- `robotmcp_project/resources/`: Shared Robot resources and keywords used by tests.
- `scripts/`: Helper scripts to run tests locally: `run_robot_tests.sh` and `run_robot_tests.ps1`.
- `.github/workflows/robot-ci.yml` (root): Main GitHub Actions workflow to install deps and run tests.
- `robotmcp_project/.github/workflows/robot.yml` (optional): alternative or per-subproject workflow.
- `.gitignore` and `.gitattributes`: keep repository clean and consistent across OSes.

Outputs and artifacts
- `results/` (local) or workflow artifact `robot-results`: CI should upload test outputs (`output.xml`, `report.html`, `log.html`) so you can download them from the Actions run.

Typical CI flow (GitHub Actions)
1. Checkout repository (`actions/checkout`).
2. Set up Python (`actions/setup-python`).
3. Install dependencies: `pip install -r robotmcp_project/requirements.txt`.
4. Run Robot Framework: `robot --outputdir results robotmcp_project/tests`.
5. Upload `results` as an artifact with `actions/upload-artifact`.

Local run commands

- PowerShell (Windows):
```
python -m pip install -r robotmcp_project/requirements.txt
python -m robot --outputdir results robotmcp_project/tests
```

- Bash (macOS / Linux):
```
python -m pip install -r robotmcp_project/requirements.txt
robot --outputdir results robotmcp_project/tests
```

Notes and recommendations
- Ensure no nested `.git` directories inside `robotmcp_project/` (CI and `git add` should include the folder in the repo).
- If tests require browsers (Selenium), use headless mode in CI and add `webdriver-manager` to `requirements.txt`.
- Keep secrets out of repo; use GitHub Secrets for credentials and reference them in the workflow.
- Use tags (example: `robotmcp`) to allow selective test runs: `robot -i robotmcp ...`.

If you want, I can also add a checklist to the repo's README linking to this document and show example workflow snippets for browser-based tests.
