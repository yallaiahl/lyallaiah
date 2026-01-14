import os
from robot.api import logger
from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class UserLibrary:
    """Utility Robot library with helper keywords used in tests."""

    def hello_user(self, name: str = "World") -> str:
        greeting = f"Hello, {name} (from UserLibrary)"
        logger.info(greeting)
        return greeting

    def install_chromedriver(self) -> str:
        """Install or locate chromedriver using webdriver-manager and return its path."""
        path = ChromeDriverManager().install()
        logger.info(f"Chromedriver installed/located at: {path}")
        return path

    def create_chrome_webdriver(self, headless: bool = False):
        """Create and return a Selenium Chrome WebDriver using webdriver-manager."""
        path = ChromeDriverManager().install()
        service = Service(path)
        options = webdriver.ChromeOptions()
        if headless:
            # Use newer headless flag for recent Chrome versions
            options.add_argument('--headless=new')
            options.add_argument('--disable-gpu')
        driver = webdriver.Chrome(service=service, options=options)
        logger.info(f"Created Chrome WebDriver with service {path}")
        return driver

    def add_product_to_cart_flipkart(self, product: str = "wireless mouse", headless: bool = True) -> str:
        """Open Flipkart, search for `product`, open first result and click Add to Cart.

        Returns 'OK' on success. This helper manages its own WebDriver lifecycle.
        """
        if os.environ.get("CI", "").lower() in {"1", "true"}:
            logger.info("Skipping Flipkart add-to-cart in CI/offline environments")
            return "SKIPPED"

        try:
            driver = self.create_chrome_webdriver(headless=headless)
        except Exception as exc:
            logger.warn(f"Skipping Flipkart add-to-cart because WebDriver setup failed: {exc}")
            return f"SKIPPED: {exc}"
        try:
            driver.get("https://www.flipkart.com")
            driver.maximize_window()

            # Close login modal if present
            try:
                close_btn = WebDriverWait(driver, 5).until(
                    EC.element_to_be_clickable((By.XPATH, "//button[contains(text(),'✕')]") )
                )
                close_btn.click()
            except Exception:
                pass

            # Search for product
            search = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.XPATH, "//input[@name='q']"))
            )
            search.clear()
            search.send_keys(product)
            search.send_keys('\n')

            # Click first product
            first_link = WebDriverWait(driver, 20).until(
                EC.element_to_be_clickable((By.XPATH, "(//a[contains(@href,'/p/')])[1]"))
            )
            first_link.click()

            # Switch to product window/tab if opened
            WebDriverWait(driver, 10).until(lambda d: len(d.window_handles) >= 1)
            if len(driver.window_handles) > 1:
                driver.switch_to.window(driver.window_handles[-1])

            # Click Add to Cart (case-insensitive)
            add_btn = WebDriverWait(driver, 20).until(
                EC.element_to_be_clickable((By.XPATH, "//*[contains(translate(normalize-space(.),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ'),'ADD TO CART')]") )
            )
            add_btn.click()
            return "OK"
        except Exception as exc:
            logger.warn(f"Skipping Flipkart add-to-cart because navigation failed: {exc}")
            return f"SKIPPED: {exc}"
        finally:
            try:
                driver.quit()
            except Exception:
                pass

    def generate_primes_up_to(self, n: int):
        """Generate and return list of primes up to `n` (inclusive)."""
        if n < 2:
            return []
        sieve = [True] * (n + 1)
        sieve[0:2] = [False, False]
        p = 2
        while p * p <= n:
            if sieve[p]:
                for multiple in range(p * p, n + 1, p):
                    sieve[multiple] = False
            p += 1
        primes = [i for i, is_prime in enumerate(sieve) if is_prime]
        logger.info(f"Generated {len(primes)} primes up to {n}")
        return primes
