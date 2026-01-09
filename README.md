# rf-mcp — Test suite

Run the example test with the workspace virtualenv:

```powershell
C:/Users/Admin/Desktop/rf-mcp/.venv/Scripts/robot.exe tests/first.robot
```

Or using the Python runner:

```powershell
C:/Users/Admin/Desktop/rf-mcp/.venv/Scripts/python.exe -m robot.run tests/first.robot
```

Flipkart add-to-cart test

Install required browser dependencies (example using Chrome):

```powershell
C:/Users/Admin/Desktop/rf-mcp/.venv/Scripts/python.exe -m pip install robotframework-seleniumlibrary selenium webdriver-manager
```

Make sure a compatible browser driver (e.g., `chromedriver`) is available on `PATH`. You can use `webdriver-manager` to fetch a driver or place the driver executable in your PATH.

Run the Flipkart add-to-cart test:

```powershell
C:/Users/Admin/Desktop/rf-mcp/.venv/Scripts/robot.exe tests/flipkart_add.robot
```

Notes:
## CI checklist

- Ensure `robotmcp_project/requirements.txt` is up-to-date and includes `robotframework` and any extra libraries (e.g. `selenium`, `webdriver-manager`).
- Ensure `robotmcp_project/tests/` contains the Robot suites to run.
- Ensure `robotmcp_project/resources/` contains any shared resources or keywords referenced by tests.
- Check that `.github/workflows/robot-ci.yml` exists at the repository root and points to `robotmcp_project/tests`.
- If tests require a browser, use headless mode and include `webdriver-manager` in `requirements.txt`.
- After pushing, verify the GitHub Actions run and download the `robot-results` artifact (or inspect the `results/` directory if running locally).

See `robotmcp_project/CI_REQUIREMENTS.md` for full details.
