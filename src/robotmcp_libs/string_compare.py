"""Robot Framework library for string comparison.

This simple library exposes two keywords:
- Compare Strings    <left>    <right>    [case_sensitive]
    returns True/False
- Assert Strings Equal    <left>    <right>    [case_sensitive]
    fails the test if strings are not equal

Place the `src` folder on PYTHONPATH or import via MCP attach using
POST /import_library with name_or_path set to the import path:
    src/robotmcp_libs/string_compare.py
or the module path:
    robotmcp_libs.string_compare

"""

from typing import Any


class StringCompare:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def Compare_Strings(self, left: Any, right: Any, case_sensitive: bool = True) -> bool:
        """Compare two values as strings and return True if equal.

        left/right: values to compare (will be cast to str)
        case_sensitive: optional boolean (default True). If False, comparison is case-insensitive.
        """
        if left is None:
            l = ""
        else:
            l = str(left)
        if right is None:
            r = ""
        else:
            r = str(right)
        if isinstance(case_sensitive, str):
            case_sensitive = case_sensitive.strip().lower() not in ("false", "0", "no", "n")
        if not case_sensitive:
            l = l.lower()
            r = r.lower()
        return l == r

    def Assert_Strings_Equal(self, left: Any, right: Any, case_sensitive: bool = True) -> None:
        """Assert that two strings are equal. Raises AssertionError on mismatch.

        This keyword is suitable for use in Robot tests.
        """
        ok = self.Compare_Strings(left, right, case_sensitive)
        if not ok:
            raise AssertionError(f"Strings not equal: left='{left}' right='{right}' case_sensitive={case_sensitive}")
