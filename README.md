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
-------------------------

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
- The test opens https://www.flipkart.com, closes the login modal if present, searches for `${PRODUCT}` and attempts to add the first product to cart.
- Web pages and element locators on Flipkart may change; adjust XPath/CSS selectors if steps fail.
