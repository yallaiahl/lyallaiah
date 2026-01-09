# CI/CD for Robot Framework — Guide

## Overview

CI/CD (Continuous Integration and Continuous Delivery) automates running your Robot Framework test suites whenever code changes occur, ensuring fast feedback and reliable releases. This guide explains concepts and practical steps to run Robot Framework tests in CI (GitHub Actions), plus delivery tips and best practices.

## Key concepts
- CI (Continuous Integration): Automatically run tests on each push or pull request to catch regressions early.
- CD (Continuous Delivery/Deployment): Automatically package, publish, or deploy artifacts after tests pass (optional for test suites; more common when tests gate releases).

## Robot Framework specifics
- Test files: `.robot` files under `robotmcp_project/tests/` (or top-level `tests/`).
- Shared resources: Put keywords in `robotmcp_project/resources/` and reference via `Resource` setting.
- Dependencies: List Python packages in `robotmcp_project/requirements.txt` (must include `robotframework` and extras such as `robotframework-seleniumlibrary`, `selenium`, `webdriver-manager` if using browser tests).
- Outputs: Robot generates `output.xml`, `report.html`, and `log.html` in an output directory (CI should collect these as artifacts).

## Example CI flow (GitHub Actions)

1. Checkout code: `actions/checkout@v4`.
2. Setup Python: `actions/setup-python@v4` and specify a `python-version`.
3. Install dependencies: `pip install -r robotmcp_project/requirements.txt`.
4. Run tests: `robot --outputdir results robotmcp_project/tests` (or multiple locations).
5. Upload artifacts: `actions/upload-artifact` to store `results/` (downloadable from Actions UI).
6. Fail the step if Robot returns non-zero (tests failed); ensure the job marks failure properly.

See the repository's workflow: `.github/workflows/robot-ci.yml` — it runs both top-level and `robotmcp_project` tests and uploads artifacts.

## Running tests locally (quick commands)

- PowerShell (Windows):
```
python -m pip install -r robotmcp_project/requirements.txt
python -m robot --outputdir results robotmcp_project/tests
```

- Bash (macOS/Linux):
```
python -m pip install -r robotmcp_project/requirements.txt
robot --outputdir results robotmcp_project/tests
```

Use the helper scripts added in `scripts/`:
- `scripts/run_robot_tests.sh` (bash)
- `scripts/run_robot_tests.ps1` (PowerShell)

## Browser / Selenium tests
- Use headless mode in CI (e.g., pass a `--variable HEADLESS:true` or configure keywords to accept a `headless` argument).
- Include `webdriver-manager` in `requirements.txt` and use it in libraries to download drivers at runtime.
- Consider using prebuilt Docker images with browsers (e.g., `selenium/standalone-chrome`) for reproducible environments.

Example keyword to create headless Chrome (already in `UserLibrary.py`): `create_chrome_webdriver(headless=True)`.

## Parallelism and test selection
- Use tags to group tests: `robot -i smoke -o output.xml tests/`.
- For parallel execution, use `pabot` (an external tool) to run suites in parallel and merge results with `rebot`.

## Caching and performance
- Cache pip packages in GitHub Actions using `actions/cache` to speed up installs.
- Cache `~/.cache/pip` or the venv directory where appropriate.

## Secrets and credentials
- Store secrets (API keys, credentials) in GitHub Secrets and pass them into the workflow via `secrets.NAME`.
- Never store secrets in repository files.

## Artifacts, reports, and notifications
- Upload `results/` as an artifact to inspect `output.xml`, `log.html`, and `report.html`.
- Optionally post results to Slack, email, or other services using notification actions.

## Failure handling & retries
- If tests are flaky, consider adding retries using the Robot Framework `--rerunfailed` / `rebot` flow or using tags to isolate flaky tests.

## Example GitHub Actions snippet

```
name: Robot Framework CI
on: [push, pull_request]
jobs:
  robot:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v4
        with: python-version: '3.11'
      - run: python -m pip install -r robotmcp_project/requirements.txt
      - run: robot --outputdir results robotmcp_project/tests
      - uses: actions/upload-artifact@v4
        with:
          name: robot-results
          path: results
```

The repository already includes a richer workflow at `.github/workflows/robot-ci.yml` that runs tests in both `tests/` and `robotmcp_project/tests`, uploads their result folders, and fails the job on test failures.

## Checklist to enable CI/CD
- [ ] `robotmcp_project/requirements.txt` exists and lists `robotframework` (+ extras).
- [ ] Robot suites are in `robotmcp_project/tests/`.
- [ ] Shared keywords/resources are in `robotmcp_project/resources/`.
- [ ] Workflow file is present at `.github/workflows/robot-ci.yml` and points to tests.
- [ ] If needed, browser drivers are handled via `webdriver-manager` or Docker images.
- [ ] GitHub Secrets configured for any credentials.

## Troubleshooting common issues
- Permission or runner environment errors: ensure the runner has Python and required packages installed.
- Execution policy (PowerShell): run Robot directly (`python -m robot`) if scripts are blocked.
- Authentication when pushing from local: configure Git credential helper or use a PAT / SSH key.

## Next improvements (suggestions)
- Add a test matrix for Python versions or browsers.
- Add caching for pip to the workflow.
- Use `pabot` to parallelize long suites.
- Add nightly scheduled runs and status badge in `README.md`.

---

If you want, I can also:
- Add a ready-to-use `actions/cache` step to `.github/workflows/robot-ci.yml`.
- Add a badge to `README.md` pointing to the `robot-ci.yml` workflow.
- Create a sample `secrets` list and show how to pass them into tests.
