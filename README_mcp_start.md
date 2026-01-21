This repository includes a small procedure to start RobotMCP and keep it running.

Files:
- [scripts/start_mcp_server.ps1](scripts/start_mcp_server.ps1) — PowerShell script that sets env vars and restarts the server on exit.
- [scripts/start_mcp_server.bat](scripts/start_mcp_server.bat) — Batch wrapper to invoke the PowerShell script.

Quick run (foreground):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\start_mcp_server.ps1
```

Run in a new hidden window (background):

```powershell
Start-Process -FilePath powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File \"$PWD\scripts\start_mcp_server.ps1\"" -WindowStyle Hidden
```

Notes and options:
- The script prefers the repo virtualenv at `.venv\Scripts\python.exe`; if missing it falls back to `python` in PATH.
- Edit the env vars at the top of `scripts/start_mcp_server.ps1` if you need a different host/port/token.
- To run as a proper Windows Service, use an external helper like `nssm` or `sc.exe` with a service wrapper.
- To stop the persistent script, terminate the PowerShell process started by the above commands.

Using the custom RobotMCP string-compare library
-----------------------------------------------

I added a small Robot Framework library at `src/robotmcp_libs/string_compare.py`.

- Local import in Robot tests (example in `tests/string_compare_example.robot`):

```robot
*** Settings ***
Library    ../src/robotmcp_libs/string_compare.py
```

- Importing while Robot is running via MCP attach (HTTP):

POST /import_library with JSON body:

```json
{ "name_or_path": "src/robotmcp_libs/string_compare.py", "args": [] }
```

Using the attach bridge: send the request to `http://127.0.0.1:7317/import_library` with header `X-MCP-Token: change-me`.

Keywords provided:
- `Compare Strings    <left>    <right>    [case_sensitive]` — returns True/False
- `Assert Strings Equal    <left>    <right>    [case_sensitive]` — fails if not equal

Example `curl` to import via MCP attach:

```bash
curl -s -H "X-MCP-Token: change-me" -H "Content-Type: application/json" \
	-d '{"name_or_path":"src/robotmcp_libs/string_compare.py"}' \
	http://127.0.0.1:7317/import_library
```

After importing, the keywords are available in the active Robot execution context.
