"""Small Robot Framework library to fetch a page and assert numbers 1..10 are present."""
from typing import List

class SiteChecker:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def Get_Numbers_From_Page(self, url: str) -> List[str]:
        """Fetches the given URL and returns a list of numbers (as strings) found on the page.

        Example: ${nums}=  Get Numbers From Page  http://127.0.0.1:8000
        """
        try:
            import urllib.request
            import re
            with urllib.request.urlopen(url, timeout=5) as resp:
                html = resp.read().decode('utf-8', errors='ignore')
        except Exception as exc:
            raise AssertionError(f"Failed to fetch {url}: {exc}")
        nums = re.findall(r"\b(?:10|[1-9])\b", html)
        return nums

    def Assert_Numbers_1_To_10_Present(self, nums: List[str]) -> None:
        """Asserts that the provided list of number-strings contains 1..10."""
        missing = [str(i) for i in range(1, 11) if str(i) not in nums]
        if missing:
            raise AssertionError(f"Missing numbers: {', '.join(missing)}")
